import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import {PackagesComponent} from './packages/packages.component'

const routes: Routes = [
  { path: '**', component: PackagesComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
