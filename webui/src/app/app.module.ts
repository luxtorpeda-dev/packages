import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { PackagesComponent } from './packages/packages.component';
import { HomeComponent } from './home/home.component';

import {MatExpansionModule} from '@angular/material/expansion';
import {MatIconModule} from '@angular/material/icon';
import {MatChipsModule} from '@angular/material/chips';
import {MatSidenavModule} from '@angular/material/sidenav';
import {MatTooltipModule} from '@angular/material/tooltip';
import { MarkdownModule } from 'ngx-markdown';
import {MatButtonModule} from '@angular/material/button';
import { HttpClient, provideHttpClient, withInterceptorsFromDi } from  '@angular/common/http';
import {MatToolbarModule} from '@angular/material/toolbar';

@NgModule({ declarations: [
        AppComponent,
        PackagesComponent,
        HomeComponent
    ],
    bootstrap: [AppComponent], imports: [BrowserModule,
        AppRoutingModule,
        BrowserAnimationsModule,
        MatExpansionModule,
        MatIconModule,
        MatChipsModule,
        MatSidenavModule,
        MatTooltipModule,
        MarkdownModule.forRoot({ loader: HttpClient }),
        MatToolbarModule,
        MatButtonModule], providers: [provideHttpClient(withInterceptorsFromDi())] })
export class AppModule { }
