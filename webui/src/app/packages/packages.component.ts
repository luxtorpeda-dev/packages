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

  //todo: move to own file
  NOTICE_MAP: any = {
    save_game_dir: 'Saves will be stored in game directory.',
    non_free: 'Non-free license.',
    '32_bit': '32-bit libraries.',
    in_progress: 'Engine is still in progress so not all features may be implemented.',
    steam_overlay_disabled: 'Steam overlay is disabled.',
    closed_source: 'Proprietary/Closed Source engine.',
    manual_steps: 'Manual steps required.',
    steam_achivements: 'Supports steam achivements.'
  };

  async ngOnInit() {
    const response = await fetch(`/packagesruntime.json`);
    this.titles = await response.json();
    this.sortTitles();
  }

  sortTitles() {
      const finalTitles: any = [];
      let defaultRecord;
      for (const titleId in this.titles) {
        if(titleId === 'engines') {
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
