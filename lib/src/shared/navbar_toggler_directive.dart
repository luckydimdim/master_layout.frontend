import 'package:angular2/core.dart';
import 'dart:html';

@Directive(selector: '[navbar-toggler]')
class NavBarTooglerDirective {
  NavBarTooglerDirective(ElementRef element) {}

  @HostListener('click')
  toggleOpen() {
    if (querySelector('body').classes.contains('sidebar-nav')) {
      querySelector('body').classes.toggle('compact-nav');

      if (querySelector('body').classes.contains('compact-nav')) {
        window.localStorage['body-class'] = 'compact-nav';
      } else {
        window.localStorage['body-class'] = '';
      }
    }

    return false;
  }
}
