import { Component, OnInit } from '@angular/core';

import { Chart, registerables, ChartConfiguration } from 'chart.js';
Chart.register(...registerables);
@Component({
  selector: 'app-jobs-status',
  standalone: true,
  imports: [],
  templateUrl: './jobs-status.component.html',
  styleUrl: './jobs-status.component.scss',
})
export class JobsStatusComponent implements OnInit {
  public config: ChartConfiguration = {
    type: 'doughnut',
    data: {
      labels: ['Pending', 'In Progress', 'Completed', 'Canceled'],
      datasets: [
        {
          label: 'Job Status',
          data: [10, 7, 20, 3],
          backgroundColor: [
            'rgb(255, 99, 132)',
            'rgb(36, 206, 206)',
            'rgb(54, 162, 235)',
            'rgb(255, 205, 86)',
          ],
          hoverOffset: 4,
        },
      ],
    },
  };

  chart: Chart | undefined;
  ngOnInit(): void {
    this.chart = new Chart('JobStatus', this.config);
  }
}
