import 'package:angular2/core.dart';
import 'dart:html';

@Directive(selector: '[aside-toggler]')
class AsideTogglerDirective {
  AsideTogglerDirective(ElementRef element) {}

  @HostListener('click')
  toggleOpen() {
    querySelector('body').classes.toggle('aside-menu-open');
    return false;
  }
}
