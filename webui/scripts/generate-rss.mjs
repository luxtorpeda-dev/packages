// scripts/generate-rss.mjs
import fs from "node:fs";
import path from "node:path";
import yaml from "js-yaml";
import RSS from "rss";

const rootUrl = `https://luxtorpeda-dev.github.io`;

const yamlPath = path.resolve("src/assets/blogPosts.yaml");

function findAngularDistDir() {
  const dist = path.resolve("dist/webui");
  if (!fs.existsSync(dist)) throw new Error("dist/webui does not exist. Run build first.");
  const entries = fs.readdirSync(dist, { withFileTypes: true });
  for (const e of entries) {
    if (e.isDirectory()) {
      const candidate = path.join(dist, e.name);
      if (fs.existsSync(path.join(candidate, "index.html"))) return candidate;
    }
  }
  if (fs.existsSync(path.join(dist, "index.html"))) return dist;
  throw new Error("Could not locate Angular output folder containing index.html.");
}

function slugify(title) {
  return title
  .toLowerCase()
  .trim()
  .replace(/['"]/g, '')
  .replace(/[^a-z0-9\s-]/g, '')
  .replace(/\s+/g, '-')
  .replace(/-+/g, '-');
}

const posts = yaml.load(fs.readFileSync(yamlPath, "utf8"));

const feed = new RSS({
  title: "Luxtorpeda Updates",
  description: "Blog describing updates to the client and various packages available.",
  feed_url: `${rootUrl}/rss.xml`,
  site_url: rootUrl,
  language: "en",
  ttl: 60,
});

for(let post of posts) {
  const slug = slugify(post.title);
  const url = `${rootUrl}/blog#${slug}`;
  const excerpt = post.body.length > 100 ? post.body.slice(0, 100) + '...' : post.body;
  feed.item({
    url,
    title: post.title,
    date: post.date,
    description: excerpt,
    guid: url
  });
}

const rssXml = feed.xml({ indent: true });

const outDir = findAngularDistDir();
fs.writeFileSync(path.join(outDir, "rss.xml"), rssXml, "utf8");
