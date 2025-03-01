import { CommonModule } from '@angular/common';
import { Component, inject } from '@angular/core';
import { RouterLink } from '@angular/router';
import { TranslateModule } from '@ngx-translate/core';
import { MultiLangService } from '../../multi-lang.service';

@Component({
  selector: 'app-navbar',
  standalone: true,
  imports: [RouterLink, TranslateModule, CommonModule],
  templateUrl: './navbar.component.html',
  styleUrl: './navbar.component.scss'
})
export class NavbarComponent {

  multiLangService = inject(MultiLangService);

  toggleLanguage(language:string):void{
    if(this.multiLangService.languageSignal() !== language){
      this.multiLangService.updateLanguage(language);
      console.log('Language change to ', language);
    }
  }

  getLanguageName(language:string):string{
    switch(language){
      case 'en':
        return 'English';
      case 'fr':
        return 'French';
      case 'es':
          return 'Spanish';
      case 'ru':
        return 'Russian';
      default:
        return 'English';
    }
  }
}
