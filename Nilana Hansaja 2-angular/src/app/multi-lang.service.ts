import { effect, inject, Injectable, signal } from '@angular/core';
import { TranslateService } from '@ngx-translate/core';

@Injectable({
  providedIn: 'root',
})
export class MultiLangService {

  translateService = inject(TranslateService);

  languageSignal = signal<string>(
    window.localStorage.getItem('languageSignal') 
    ? JSON.parse(window.localStorage.getItem('languageSignal')!) 
    : 'en'
  );

  updateLanguage(language: string): void {
    this.languageSignal.update(() => {
      switch (language) {
        case 'en':
          return 'en';
        case 'fr':
          return 'fr';
        case 'es':
          return 'es';
        case 'ru':
          return 'ru';
        default:
          return 'en';
      }
    });
  }

  constructor() { 
    effect(()=>{
      window.localStorage.setItem('languageSignal',JSON.stringify(this.languageSignal()));
      this.translateService.use(this.languageSignal());
      console.log(this.languageSignal);
    })
  }
}
