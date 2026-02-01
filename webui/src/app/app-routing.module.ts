import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import {PackagesComponent} from './packages/packages.component'
import {BlogComponent} from './blog/blog.component'
import {HomeComponent} from './home/home.component'

const routes: Routes = [
  { path: 'packages', component: PackagesComponent },
  { path: 'blog', component: BlogComponent },
  { path: '**', component: HomeComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes, {
    anchorScrolling: 'enabled',
    scrollPositionRestoration: 'enabled',
  })],
  exports: [RouterModule]
})
export class AppRoutingModule { }
