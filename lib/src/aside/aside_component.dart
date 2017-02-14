import 'dart:html';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

@Component(selector: 'aside')
@View(templateUrl: 'aside_component.html')
class AsideComponent implements AfterViewInit {
  final Router _router;

  AsideComponent(this._router) {}

  @override
  void ngAfterViewInit() {}
}
