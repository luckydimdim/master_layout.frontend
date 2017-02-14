import 'dart:html';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:angular_utils/directives.dart';

@Component(selector: 'sidebar')
@View(templateUrl: 'sidebar_component.html', directives: const [CmRouterLink])
class SidebarComponent implements AfterViewInit {
  final Router _router;

  SidebarComponent(this._router) {}

  @override
  void ngAfterViewInit() {
    var bodyClass = window.localStorage['body-class'];

    if (bodyClass == 'compact-nav') {
      querySelector('body').classes.add('compact-nav');
    }
  }
}
