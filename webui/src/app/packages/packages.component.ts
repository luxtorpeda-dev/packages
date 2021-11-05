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

  NOTICE_MAP: any = {};

  async ngOnInit() {
    const response = await fetch(`/packagesruntime.json`);
    this.titles = await response.json();
    this.sortTitles();
  }

  sortTitles() {
      const finalTitles: any = [];
      let defaultRecord;

      this.NOTICE_MAP = this.titles.noticeMap;

      for (const titleId in this.titles) {
        if(titleId === 'engines' || titleId === 'noticeMap') {
          continue;
        }

        this.titles[titleId].titleId = titleId;
        this.titles[titleId].engines = {};

        if(this.titles[titleId].engine_name) {
          const engineName = this.titles[titleId].engine_name;
          if(this.titles.engines[engineName]) {
            this.titles[titleId].engines[engineName] = this.titles.engines[engineName];
          } else {
            console.error(`engineName of ${engineName} not found from title of ${titleId}`);
          }
        } else if(this.titles[titleId].engine_names) {
          for(let engineName of this.titles[titleId].engine_names) {
            if(this.titles.engines[engineName]) {
              this.titles[titleId].engines[engineName] = this.titles.engines[engineName];
            } else {
              console.error(`engineName of ${engineName} not found from title of ${titleId}`);
            }
          }
        } else if(this.titles[titleId].choices) {
          for(let choice of this.titles[titleId].choices) {
            const engineName = choice.name;
            if(this.titles.engines[engineName]) {
              this.titles[titleId].engines[engineName] = this.titles.engines[engineName];
            } else if (choice.engine_name && this.titles.engines[choice.engine_name]) {
                this.titles[titleId].engines[choice.engine_name] = this.titles.engines[choice.engine_name];
            } else {
              console.error(`engineName of ${engineName} not found from title of ${titleId}`);
            }
          }
        } else {
            console.error(`missing information for ${titleId}`);
        }

        const engineKeysSorted = Object.keys(this.titles[titleId].engines);
        engineKeysSorted.sort();

        this.titleEnginePicked[titleId] = engineKeysSorted[0];

        for(let engineKey in this.titles[titleId].engines) {
          const tmpEngine = JSON.parse(JSON.stringify(this.titles[titleId].engines[engineKey]));

          if(this.titles[titleId].notices) {
            if(!tmpEngine.notices) {
              tmpEngine.notices = [];
            }
            for(let notice of this.titles[titleId].notices) {
             tmpEngine.notices.push(notice);
            }
          }

          if(tmpEngine.notices) {
              for(let notice of tmpEngine.notices) {
                if(notice.key === 'manual_steps') {
                  tmpEngine.manualSteps = true;
                }
                if(notice.key === 'steam_overlay_disabled') {
                  tmpEngine.steamOverlayDisabled = true;
                }
                if(notice.key === 'in_progress') {
                  tmpEngine.inProgress = true;
                }
              }
          }

          this.titles[titleId].engines[engineKey] = tmpEngine;
        }

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
  }

  onEngineClicked($event: any, title: any, engineKey: any) {
    this.titleEnginePicked[title.titleId] = engineKey;
  }
}
