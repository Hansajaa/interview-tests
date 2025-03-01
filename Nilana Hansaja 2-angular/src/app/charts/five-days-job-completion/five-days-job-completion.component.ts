import { Component, OnInit } from '@angular/core';

import { Chart, registerables, ChartConfiguration } from 'chart.js';
Chart.register(...registerables);
@Component({
  selector: 'app-five-days-job-completion',
  standalone: true,
  imports: [],
  templateUrl: './five-days-job-completion.component.html',
  styleUrl: './five-days-job-completion.component.scss'
})
export class FiveDaysJobCompletionComponent implements OnInit{
  public config: ChartConfiguration = {
    type: 'bar',
    data: {
      labels: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"],
      datasets: [{
        label: 'Job Completion',
        data: [65, 59, 80, 81, 56],
        backgroundColor: [
          'rgba(255, 99, 132, 0.2)',
          'rgba(255, 159, 64, 0.2)',
          'rgba(255, 205, 86, 0.2)',
          'rgba(75, 192, 192, 0.2)',
          'rgba(54, 162, 235, 0.2)',
        ],
        borderColor: [
          'rgb(255, 99, 132)',
          'rgb(255, 159, 64)',
          'rgb(255, 205, 86)',
          'rgb(75, 192, 192)',
          'rgb(54, 162, 235)',
        ],
        borderWidth: 1
      }]
    },
    options: {
      scales: {
        y: {
          beginAtZero: true
        }
      }
    },
  };
  
  chart:Chart | undefined;
  ngOnInit(): void {
    this.chart = new Chart('fiveDaysJobCompletion', this.config);
  }

}
