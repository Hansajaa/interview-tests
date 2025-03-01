import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { TranslateModule } from '@ngx-translate/core';

@Component({
  selector: 'app-jobs-table',
  standalone: true,
  imports: [CommonModule, TranslateModule],
  templateUrl: './jobs-table.component.html',
  styleUrl: './jobs-table.component.scss',
})
export class JobsTableComponent {
  statuses = ['pending', 'inProgress', 'completed', 'canceled'];

  // sample jobs array
  jobs = [
    {
      cardID: 'CRD00000001',
      Job: 'Full Service',
      currentStatus: 'inProgress',
      licensePlate: 'KL-0765',
      cost: 40000.0,
      note: 'sample note',
    },
    {
      cardID: 'CRD00000002',
      Job: 'Body Wash',
      currentStatus: 'Canceled',
      licensePlate: 'CAL-0715',
      cost: 30000.0,
      note: '0765414327',
    },
    {
      cardID: 'CRD00000003',
      Job: 'vacuum',
      currentStatus: 'Pending',
      licensePlate: 'KL-1115',
      cost: 500.0,
      note: '0715434369',
    },
    {
      cardID: 'CRD00000004',
      Job: 'EFI Tunning',
      currentStatus: 'inProgress',
      licensePlate: '301-1398',
      cost: 45000.0,
      note: '0766503598',
    },
    {
      cardID: 'CRD00000005',
      Job: 'Body Wash and vacuum',
      currentStatus: 'Pending',
      licensePlate: 'KW-9098',
      cost: 1000.0,
      note: '0765134367',
    },
    {
      cardID: 'CRD00000006',
      Job: 'Full Scan',
      currentStatus: 'Completed',
      licensePlate: 'KM-0987',
      cost: 5000.0,
      note: '0715444361',
    },
  ];
}
