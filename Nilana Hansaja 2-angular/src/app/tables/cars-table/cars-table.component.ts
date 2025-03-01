import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { TranslateModule } from '@ngx-translate/core';

@Component({
  selector: 'app-cars-table',
  standalone: true,
  imports: [CommonModule, TranslateModule],
  templateUrl: './cars-table.component.html',
  styleUrl: './cars-table.component.scss',
})
export class CarsTableComponent {

  // sample cars array
  cars = [
    {
      id: 1,
      make: 'Honda',
      model: 'Civic FD3',
      year: '2010',
      licensePlate: 'KL-0765',
      ownerName: 'Nimal Perera',
      ownerNo: '0765434367',
    },
    {
      id: 2,
      make: 'Toyota',
      model: 'Axio',
      year: '2020',
      licensePlate: 'CAL-0715',
      ownerName: 'Sadun Perera',
      ownerNo: '0765414327',
    },
    {
      id: 3,
      make: 'Ford',
      model: 'Mustang',
      year: '2015',
      licensePlate: 'KL-1115',
      ownerName: 'Upul Fernando',
      ownerNo: '0715434369',
    },
    {
      id: 4,
      make: 'Honda',
      model: 'Civic ek3',
      year: '2003',
      licensePlate: '301-1398',
      ownerName: 'Nilana Hansaja',
      ownerNo: '0766503598',
    },
    {
      id: 5,
      make: 'BMW',
      model: '520d',
      year: '2010',
      licensePlate: 'KW-9098',
      ownerName: 'Prabath Perera',
      ownerNo: '0765134367',
    },
    {
      id: 6,
      make: 'Toyota',
      model: 'Land Cruiser v8',
      year: '2008',
      licensePlate: 'KM-0987',
      ownerName: 'Nihal Perera',
      ownerNo: '0715444361',
    },
  ];
}
