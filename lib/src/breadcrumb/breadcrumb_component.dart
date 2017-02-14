import 'dart:html';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

@Component(selector: 'breadcrumb')
@View(templateUrl: 'breadcrumb_component.html')
class BreadcrumbComponent implements AfterViewInit {
  final Router _router;

  BreadcrumbComponent(this._router) {}

  @override
  void ngAfterViewInit() {
/*
    print('BreadcrumbComponent init');

    print('root: ${this._router.root}');
    print('host: ${this._router.hostComponent}');
    print('parent: ${this._router.parent}');

    this._router.root.subscribe((e){

      print('onNext: $e');
      print('root: ${this._router.root}');
      print('host: ${this._router.hostComponent}');
      print('parent: ${this._router.parent}');

    });*/
  }
}
