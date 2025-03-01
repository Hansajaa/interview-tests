import { ComponentFixture, TestBed } from '@angular/core/testing';

import { FiveDaysJobCompletionComponent } from './five-days-job-completion.component';

describe('FiveDaysJobCompletionComponent', () => {
  let component: FiveDaysJobCompletionComponent;
  let fixture: ComponentFixture<FiveDaysJobCompletionComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [FiveDaysJobCompletionComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(FiveDaysJobCompletionComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
