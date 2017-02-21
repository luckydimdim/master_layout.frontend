import 'package:angular2/core.dart';
import 'dart:html';

@Directive(selector: '[navbar-toggler]')
class NavBarTooglerDirective {
  final ElementRef _element;

  NavBarTooglerDirective(ElementRef this._element) {}

  @HostListener('click')
  toggleOpen() {
    var trigger = _element.nativeElement as HtmlElement;
    if (trigger == null)
      return false;

    String classToToggle = '';
    if (trigger.classes.contains('mobile-toggler'))
      classToToggle = 'mobile-open';
    else
      classToToggle = 'compact-nav';

    querySelector('body').classes.toggle(classToToggle);

    if (querySelector('body').classes.contains(classToToggle)) {
      window.localStorage['body-class'] = classToToggle;
    } else {
      window.localStorage['body-class'] = '';
    }

    return false;
  }
}
