import { Component } from '@angular/core';
import { RouterLink } from '@angular/router';
import { CarsTableComponent } from '../../tables/cars-table/cars-table.component';
import { TranslateModule } from '@ngx-translate/core';

@Component({
  selector: 'app-add-car',
  standalone: true,
  imports: [CarsTableComponent,RouterLink, TranslateModule],
  templateUrl: './add-car.component.html',
  styleUrl: './add-car.component.scss'
})
export class AddCarComponent {

}
