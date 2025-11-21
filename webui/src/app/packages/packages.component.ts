import { Component, OnInit } from '@angular/core';

@Component({
    selector: 'app-packages',
    templateUrl: './packages.component.html',
    styleUrls: ['./packages.component.css'],
    standalone: false
})
export class PackagesComponent implements OnInit {

  constructor() { }

  titles: any = [];
  titleEnginePicked: any = {};

  NOTICE_MAP: any = {};

  runControllerCheck = true;

  async ngOnInit() {
    const response = await fetch(`/packagessniper_v2.json`);
    this.titles = await response.json();
    this.enginesToMap();
    this.noticeTranslationToMap();
    this.sortTitles();
  }

  noticeTranslationToMap() {
    for(let notice of this.titles.notice_translation) {
      this.NOTICE_MAP[notice.key] = notice.value;
    }
  }

  enginesToMap() {
    const finalEngines: any = {};
    for(let engine of this.titles.engines) {
      finalEngines[engine.engine_name] = engine;
    }
    this.titles.engines = finalEngines;
  }

  translate_key(key: string) {
    return this.NOTICE_MAP[key];
  }

  processTitle(title: any) {
    const titleId = title.app_id;
    title.engines = {};

    if(title.cloudAvailable && !title.cloudSupported && !title.cloudIssue) {
      console.error(`title of ${title.game_name} has unknown cloud save feature state`);
    }

    if(title.engine_name) {
      const engineName = title.engine_name;
      if(this.titles.engines[engineName]) {
        title.engines[engineName] = this.titles.engines[engineName];
      } else {
        console.error(`engineName of ${engineName} not found from title of ${titleId}`);
      }
    } else if(title.engine_names) {
      for(let engineName of title.engine_names) {
        if(this.titles.engines[engineName]) {
          title.engines[engineName] = this.titles.engines[engineName];
        } else {
          console.error(`engineName of ${engineName} not found from title of ${titleId}`);
        }
      }
    } else if(title.choices) {
      for(let choice of title.choices) {
        const engineName = choice.name;
        if(this.titles.engines[engineName]) {
          title.engines[engineName] = this.titles.engines[engineName];
        } else if (choice.engine_name && this.titles.engines[choice.engine_name]) {
            title.engines[choice.engine_name] = this.titles.engines[choice.engine_name];
        } else {
          console.error(`engineName of ${engineName} not found from title of ${titleId}`);
        }
      }
    } else {
        console.error(`missing information for ${titleId}`);
    }

    const engineKeysSorted = Object.keys(title.engines);
    engineKeysSorted.sort();

    this.titleEnginePicked[titleId] = engineKeysSorted[0];

    for(let engineKey in title.engines) {
      const tmpEngine = JSON.parse(JSON.stringify(title.engines[engineKey]));

      if(title.notices) {
        if(!tmpEngine.notices) {
          tmpEngine.notices = [];
        }
        for(let notice of title.notices) {
          tmpEngine.notices.push(notice);
        }
      }

      if(title.removeNotices) {
        const finalNotices = [];
        for(let notice of tmpEngine.notices) {
          let okToAdd = true;
          for(let removeKey of title.removeNotices) {
            if(notice.key === removeKey) {
              okToAdd = false;
              break;
            }
          }

          if(okToAdd) {
            finalNotices.push(notice);
          }
        }

        tmpEngine.notices = finalNotices;
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

      title.engines[engineKey] = tmpEngine;
    }
    return title;
  }

  sortTitles() {
      const finalTitles: any = [];
      let defaultRecord: any = this.titles.default_engine;

      if(this.runControllerCheck) {
        for(const engineKey in this.titles.engines) {
          const engine = this.titles.engines[engineKey];
          let foundController = false;
          for(let engineKey of Object.keys(engine)) {
            if(engineKey.indexOf('controller') !== -1) {
              foundController = true;
              break;
            }
          }

          if(!foundController) {
            console.error(`missing controller data for ${engine.engine_name}`);
          }
        }
      }

      for (let title of this.titles.games) {
        title.titleId = title.app_id;
        title = this.processTitle(title);
        finalTitles.push(title);
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
      defaultRecord.isDefault = true;
      defaultRecord.titleId = 'default';
      defaultRecord.app_id = 'default';
      defaultRecord = this.processTitle(defaultRecord);
      finalTitles.unshift(defaultRecord);
    }

    this.titles = finalTitles;
  }

  onEngineClicked($event: any, title: any, engineKey: any) {
    this.titleEnginePicked[title.titleId] = engineKey;
  }
}
