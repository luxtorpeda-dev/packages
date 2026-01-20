import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import * as yaml from 'js-yaml';

@Component({
    selector: 'app-blog',
    templateUrl: './blog.component.html',
    styleUrls: ['./blog.component.css'],
    standalone: false
})
export class BlogComponent implements OnInit {

  constructor(private cdr: ChangeDetectorRef) { }

  posts: any = [];

  async ngOnInit() {
    const response = await fetch(`/blogPosts.yaml`);
    const text = await response.text();
    this.posts = yaml.load(text);
    console.log(this.posts)
    this.cdr.detectChanges();
  }
}
