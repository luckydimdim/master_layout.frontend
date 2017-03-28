import 'dart:html';

import 'package:angular2/core.dart';

import 'package:aside/aside_service.dart';

@Directive(selector: '[aside-toggler]')
class AsideTogglerDirective {
  AsideService _service = null;

  AsideTogglerDirective(ElementRef element, this._service);

  @HostListener('click')
  toggleOpen() {
    _service.togglePane();
  }
}
