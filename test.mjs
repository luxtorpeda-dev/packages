import { readFile } from 'fs/promises';
import path from 'path';
import { fileURLToPath } from 'url';

// Helper function to combine a base URL and file path correctly.
function combineUrlAndFile(url, file) {
    return `${url.replace(/\/+$/, '')}/${file.replace(/^\/+/, '')}`;
}

// Global array to collect issues found during checks.
const issuesFound = [];

// Resolve __dirname in an ES module.
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Build the file path relative to the script location.
const filePath = path.join(__dirname, 'metadata', 'packagessniper_v2.json');

// Helper async function to process a download array from a given source.
async function processDownloadArray(downloadArray, gameName, appId) {
    for (const downloadEntry of downloadArray) {
        const name = downloadEntry.name ? downloadEntry.name.toLowerCase() : '';
        const url = downloadEntry.url || '';

        // 1. Network (HEAD) Check:
        // If the URL does NOT contain the special luxtorpeda-dev/packages substring,
        // perform a HEAD request to check if the resource is downloadable.
        if (!url.includes('https://github.com/luxtorpeda-dev/packages')) {
            let fullUrl;
            try {
                // Use our helper to combine the URL and file.
                fullUrl = combineUrlAndFile(url, downloadEntry.file);
            } catch (e) {
                issuesFound.push({
                    download_name: downloadEntry.name,
                    download_status: null,
                    download_status_text: `Invalid URL: ${e.message}`,
                    full_url: null,
                    game_name: gameName,
                    game_app_id: appId,
                    type: "network_error"
                });
                // Skip further processing for this download entry.
                continue;
            }
            try {
                const response = await fetch(fullUrl, { method: 'HEAD' });
                if (response.status !== 200) {
                    issuesFound.push({
                        download_name: downloadEntry.name,
                        download_status: response.status,
                        download_status_text: response.statusText,
                        full_url: fullUrl,
                        game_name: gameName,
                        game_app_id: appId,
                        type: "network_error"
                    });
                }
            } catch (err) {
                issuesFound.push({
                    download_name: downloadEntry.name,
                    download_status: null,
                    download_status_text: err.message,
                    full_url: fullUrl,
                    game_name: gameName,
                    game_app_id: appId,
                    type: "network_error"
                });
            }
        }

        // 2. GitHub Release Check:
        // Define ignore conditions that will prevent the GitHub release check.
        const ignoreConditions = [
            url.includes('https://github.com/luxtorpeda-dev/packages'),
            name.includes('openjdk'),
            url.includes('quaddicted'),
            name.includes('soundfont'),
            url.includes('ioquake3.org'),
            url.includes('icculus.org'),
            name.includes('soundtrack'),
            name.includes('catalogue'),
            url.includes('slashbunny'),
            url.includes('unreal-archive-files'),
            url.includes('nwjs.io'),
            url.includes('playmorepromode.com'),
            url.includes('daikatana/tree'),
            name.includes('music'),
            name.includes('rvgl'),
            name === 'eawpats'
        ];

        // Only proceed with the GitHub release check if none of the ignore conditions are met.
        if (!ignoreConditions.some(Boolean)) {
            if (url.includes('github.com') && url.includes('/releases/')) {
                try {
                    const parsedUrl = new URL(url);
                    const parts = parsedUrl.pathname.split('/').filter(Boolean);
                    // Expected pattern: [owner, repo, "releases", "download", releaseTag, ...]
                    if (parts.length >= 5) {
                        const owner = parts[0];
                        const repo = parts[1];
                        const releaseTag = parts[4];

                        // Construct the current URL using the helper.
                        const currentUrl = combineUrlAndFile(url, downloadEntry.file);

                        // Call the GitHub API to get the latest release info.
                        const apiUrl = `https://api.github.com/repos/${owner}/${repo}/releases/latest`;
                        const apiResponse = await fetch(apiUrl);
                        if (apiResponse.ok) {
                            const latestRelease = await apiResponse.json();
                            const latestTag = latestRelease.tag_name;
                            // Only record a new_release issue if:
                            // 1. The latest tag is different from the releaseTag from the URL.
                            // 2. The latest tag does not include "-rc".
                            if (latestTag !== releaseTag && !latestTag.includes('-rc')) {
                                issuesFound.push({
                                    download_name: downloadEntry.name,
                                    game_name: gameName,
                                    game_app_id: appId,
                                    type: "new_release",
                                    new_version: latestTag,
                                    current_release: releaseTag,
                                    current_url: currentUrl
                                });
                            }
                        }
                    }
                } catch (err) {
                    // In case of an error during GitHub release checking, we simply ignore it.
                }
            }
        }
    }
}

try {
    // Read and parse the JSON file using top-level await.
    const data = await readFile(filePath, 'utf-8');
    const jsonData = JSON.parse(data);

    // Process the "games" array if present.
    if (Array.isArray(jsonData.games)) {
        for (const game of jsonData.games) {
            const gameName = game.game_name || "unknown";
            const appId = game.app_id;
            if (Array.isArray(game.download)) {
                await processDownloadArray(game.download, gameName, appId);
            }
        }
    } else {
        console.error('No games array found in JSON file.');
    }

    // Process the "default_engine" if it exists and contains a download array.
    if (jsonData.default_engine && Array.isArray(jsonData.default_engine.download)) {
        await processDownloadArray(
            jsonData.default_engine.download,
            "default",
            "default"
        );
    }

    // Output the issues found.
    console.log("Issues Found:");
    console.log(issuesFound);
} catch (error) {
    console.error('Error processing the file:', error);
}
