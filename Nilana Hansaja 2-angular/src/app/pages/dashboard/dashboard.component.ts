import { Component } from '@angular/core';
import { RouterLink } from '@angular/router';
import { JobsStatusComponent } from '../../charts/jobs-status/jobs-status.component';
import { FiveDaysJobCompletionComponent } from '../../charts/five-days-job-completion/five-days-job-completion.component';
import { FiveDaysIncomeComponent } from '../../charts/five-days-income/five-days-income.component';
import { TranslateModule } from '@ngx-translate/core';


@Component({
  selector: 'app-dashboard',
  standalone: true,
  imports: [RouterLink,JobsStatusComponent, FiveDaysJobCompletionComponent, FiveDaysIncomeComponent, TranslateModule],
  templateUrl: './dashboard.component.html',
  styleUrl: './dashboard.component.scss'
})
export class DashboardComponent {

}
