import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import {PackagesComponent} from './packages/packages.component'
import {HomeComponent} from './home/home.component'

const routes: Routes = [
  { path: 'packages', component: PackagesComponent },
  { path: '**', component: HomeComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
