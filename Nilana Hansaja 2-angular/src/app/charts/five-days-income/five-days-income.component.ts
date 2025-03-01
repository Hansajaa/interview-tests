import { Component, OnInit } from '@angular/core';

import { Chart, registerables, ChartConfiguration } from 'chart.js';
Chart.register(...registerables);
@Component({
  selector: 'app-five-days-income',
  standalone: true,
  imports: [],
  templateUrl: './five-days-income.component.html',
  styleUrl: './five-days-income.component.scss',
})
export class FiveDaysIncomeComponent implements OnInit {
  public config: ChartConfiguration = {
    type: 'line',
    data: {
      labels: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'],
      datasets: [
        {
          label: 'Income (Rs.)',
          data: [50000, 34000, 25000, 80000, 67000],
          borderColor: 'rgb(255,99,132)',
          backgroundColor: 'rgb(255,99,132)',
        }
      ],
    },
    options: {
      responsive: true,
      plugins: {
        legend: {
          position: 'top',
        },
        title: {
          display: true,
          text: 'Previous Five Days Income',
        },
      },
    },
  };

  chart:Chart | undefined;
  ngOnInit(): void {
    this.chart = new Chart('fiveDaysIncome', this.config);
  }
}
