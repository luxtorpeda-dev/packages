import { Component, OnInit, ChangeDetectorRef, NgZone } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import * as yaml from 'js-yaml';
import { filter, take, distinctUntilChanged, map } from 'rxjs/operators';
import { Observable } from 'rxjs';

@Component({
    selector: 'app-blog',
    templateUrl: './blog.component.html',
    styleUrls: ['./blog.component.css'],
    standalone: false
})
export class BlogComponent implements OnInit {

  constructor(private cdr: ChangeDetectorRef, private route: ActivatedRoute, private zone: NgZone) { }

  posts: any = [];
  isInitialScrollInProgress = false;
  initialScrollTarget: string | null = null;

  async ngOnInit() {
    const response = await fetch(`/blogPosts.yaml`);
    const text = await response.text();
    this.posts = yaml.load(text);
    this.cdr.detectChanges();

    const initialHash = window.location.hash
      ? decodeURIComponent(window.location.hash.slice(1))
      : '';

    if (initialHash) {
      setTimeout(() => {
        this.isInitialScrollInProgress = true;
        this.initialScrollTarget = initialHash;
        this.cdr.detectChanges();
      }, 0);

      void this.scrollToFragmentReliable(initialHash).finally(() => {
        this.isInitialScrollInProgress = false;
        this.initialScrollTarget = null;
        this.cdr.detectChanges();
      });
    }

    this.route.fragment
      .pipe(
        filter((f): f is string => typeof f === 'string' && f.length > 0),
            map(f => f as string),
            distinctUntilChanged()
      )
      .subscribe(fragment => {
        void this.scrollToFragmentReliable(fragment);
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

  private async scrollToFragmentReliable(fragment: string) {
    await this.waitForZoneStable();
    await this.nextFrame();
    await this.waitForZoneStable();

    const el = await this.waitForElementById(fragment, 15000);
    if (!el) {
      return;
    }

    el.scrollIntoView({ behavior: 'smooth', block: 'start' });

    await this.waitForImages(el);

    await this.nextFrame();
    el.scrollIntoView({ behavior: 'auto', block: 'start' });

    setTimeout(() => {
      el.scrollIntoView({ behavior: 'auto', block: 'start' });
    }, 200);
  }

  private waitForZoneStable(timeoutMs = 500): Promise<void> {
    return new Promise(resolve => {
      let resolved = false;

      const sub = this.zone.onStable.pipe(take(1)).subscribe(() => {
        resolved = true;
        sub.unsubscribe();
        resolve();
      });

      setTimeout(() => {
        if (!resolved) {
          sub.unsubscribe();
          resolve();
        }
      }, timeoutMs);
    });
  }

  private waitForElementById(id: string, timeoutMs = 5000): Promise<HTMLElement | null> {
    const get = () => document.getElementById(id) as HTMLElement | null;

    const existing = get();
    if (existing) return Promise.resolve(existing);

    return new Promise(resolve => {
      const obs = new MutationObserver(() => {
        const el = get();
        if (el) {
          obs.disconnect();
          resolve(el);
        }
      });

      obs.observe(document.body, { childList: true, subtree: true });

      const immediate = get();
      if (immediate) {
        obs.disconnect();
        resolve(immediate);
        return;
      }

      setTimeout(() => {
        obs.disconnect();
        resolve(get());
      }, timeoutMs);
    });
  }

  private async waitForImages(container: HTMLElement): Promise<void> {
    const imgs = Array.from(container.querySelectorAll('img')) as HTMLImageElement[];
    if (imgs.length === 0) return;

    await Promise.all(
      imgs.map(img => {
        if (img.complete && img.naturalWidth > 0) {
          return (img.decode?.() ?? Promise.resolve()).catch(() => {});
        }

        return new Promise<void>(resolve => {
          const done = () => resolve();
          img.addEventListener('load', done, { once: true });
          img.addEventListener('error', done, { once: true });
        });
      })
    );

    await (document.fonts?.ready ?? Promise.resolve());
  }

  private nextFrame(): Promise<void> {
    return new Promise(resolve => requestAnimationFrame(() => resolve()));
  }
}
