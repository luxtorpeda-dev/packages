import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-packages',
  templateUrl: './packages.component.html',
  styleUrls: ['./packages.component.css']
})
export class PackagesComponent implements OnInit {

  constructor() { }

  titles: any = [];
  titleEnginePicked: any = {};

  async ngOnInit() {
    const response = await fetch(`/packagesruntime.json`);
    this.titles = await response.json();
    this.sortTitles();
  }

  sortTitles() {
      const finalTitles: any = [];
      let defaultRecord;
      for (const titleId in this.titles) {
        this.titles[titleId].titleId = titleId;
        if(!this.titles[titleId].engines && this.titles[titleId].information) {
            if(!Array.isArray(this.titles[titleId].information)) {
              this.titles[titleId].information = [this.titles[titleId].information];
            }
            this.titles[titleId].engines = {};

            for(let informationItem of this.titles[titleId].information) {
                this.titles[titleId].engines[informationItem.engine_name] = informationItem;

                if(!this.titles[titleId].engines[informationItem.engine_name].notices) {
                  this.titles[titleId].engines[informationItem.engine_name].notices = [];
                }

                if(informationItem.non_free) {
                    this.titles[titleId].engines[informationItem.engine_name].notices.push({"key": "non_free", "label": "Non-free license"});
                }

                if(informationItem["32-bit"]) {
                    this.titles[titleId].engines[informationItem.engine_name].notices.push({"key": "32-bit", "label": "32-bit libraries"});
                }

                if(informationItem.comments) {
                    this.titles[titleId].engines[informationItem.engine_name].notices.push({"label": informationItem.comments});
                }
            }
        }

        if(!this.titles[titleId].information) {
          continue;
        }

        const engineKeysSorted = Object.keys(this.titles[titleId].engines);
        engineKeysSorted.sort();

        this.titleEnginePicked[titleId] = engineKeysSorted[0];

        if(titleId === 'default') {
          this.titles[titleId].isDefault = true;
          defaultRecord = this.titles[titleId];
          continue;
        }

        finalTitles.push(this.titles[titleId]);
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

    if(defaultRecord) {
      finalTitles.unshift(defaultRecord);
    }

    this.titles = finalTitles;

    console.log("ASDADS", this.titles);
  }

  onEngineClicked($event: any, title: any, engineKey: any) {
    this.titleEnginePicked[title.titleId] = engineKey;
  }
}
