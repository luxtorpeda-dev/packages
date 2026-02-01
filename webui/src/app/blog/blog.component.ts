import { Component, OnInit, ChangeDetectorRef, NgZone } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import * as yaml from 'js-yaml';
import { take } from 'rxjs/operators';

@Component({
    selector: 'app-blog',
    templateUrl: './blog.component.html',
    styleUrls: ['./blog.component.css'],
    standalone: false
})
export class BlogComponent implements OnInit {

  constructor(private cdr: ChangeDetectorRef, private route: ActivatedRoute, private zone: NgZone) { }

  posts: any = [];

  async ngOnInit() {
    const response = await fetch(`/blogPosts.yaml`);
    const text = await response.text();
    this.posts = yaml.load(text);
    this.cdr.detectChanges();

    const fragment = this.route.snapshot.fragment;
    console.log(`found fragment of: ${fragment}`);
    if (fragment) {
      this.scrollToFragment(fragment);
    }
  }

  private scrollToFragment(fragment: string) {
    const existing = document.getElementById(fragment);
    if (existing) {
      existing.scrollIntoView({ behavior: 'smooth', block: 'start' });
      return;
    }

    this.zone.onStable.pipe(take(1)).subscribe(() => {
      const observer = new MutationObserver(() => {
        const el = document.getElementById(fragment);
        if (el) {
          observer.disconnect();
          el.scrollIntoView({ behavior: 'smooth', block: 'start' });
        }
      });

      observer.observe(document.body, { childList: true, subtree: true });

      window.setTimeout(() => observer.disconnect(), 5000);
    });
  }

  slugify(title: string): string {
    return title
    .toLowerCase()
    .trim()
    .replace(/['"]/g, '')
    .replace(/[^a-z0-9\s-]/g, '')
    .replace(/\s+/g, '-')
    .replace(/-+/g, '-');
  }
}
