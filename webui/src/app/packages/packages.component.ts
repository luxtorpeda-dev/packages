import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-packages',
  templateUrl: './packages.component.html',
  styleUrls: ['./packages.component.css']
})
export class PackagesComponent implements OnInit {

  constructor() { }

  titles: any = [];

  async ngOnInit() {
    const response = await fetch(`/packagesruntime.json`);
    this.titles = await response.json();
    this.sortTitles();
  }

  sortTitles() {
      const finalTitles: any = [];
      for (const titleId in this.titles) {
        if(this.titles[titleId].information) {
          if(!Array.isArray(this.titles[titleId].information)) {
            this.titles[titleId].information = [this.titles[titleId].information];
          }
          this.titles[titleId].titleId = titleId;
          finalTitles.push(this.titles[titleId]);
        }
     }

     finalTitles.sort(function (a: any, b: any) {
      if (a.game_name < b.game_name) {
        return -1;
      }
      if (a.game_name > b.game_name) {
        return 1;
      }
      return 0;
    });

    this.titles = finalTitles;
  }
}
