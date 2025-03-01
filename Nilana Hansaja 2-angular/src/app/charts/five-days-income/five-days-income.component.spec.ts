import { ComponentFixture, TestBed } from '@angular/core/testing';

import { FiveDaysIncomeComponent } from './five-days-income.component';

describe('FiveDaysIncomeComponent', () => {
  let component: FiveDaysIncomeComponent;
  let fixture: ComponentFixture<FiveDaysIncomeComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [FiveDaysIncomeComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(FiveDaysIncomeComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
