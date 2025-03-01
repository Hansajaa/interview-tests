import { Routes } from '@angular/router';
import { AddCarComponent } from './pages/add-car/add-car.component';
import { AddJobComponent } from './pages/add-job/add-job.component';
import { DashboardComponent } from './pages/dashboard/dashboard.component';
import { HomeComponent } from './pages/home/home.component';

export const routes: Routes = [
    {
        component: HomeComponent,
        path:''
    },
    {
        component: AddCarComponent,
        path:'addCar'
    },
    {
        component: AddJobComponent,
        path:'addJob'
    },
    {
        component: DashboardComponent,
        path:'dashboard'
    },
];
