import 'dart:html';

import 'package:angular2/core.dart';
import 'package:angular_utils/directives.dart';
import 'package:auth/auth_service.dart';

@Component(
    selector: 'sidebar',
    templateUrl: 'sidebar_component.html',
    directives: const [CmRouterLink])
class SidebarComponent implements AfterViewInit {

  final AuthorizationService _authorizationService;

  SidebarComponent(this._authorizationService) {
    isAdmin = _authorizationService.isInRole(Role.Administrator);
    isCustomer = _authorizationService.isInRole(Role.Customer);
    isContractor = _authorizationService.isInRole(Role.Contractor);
  }

  bool isAdmin = false;
  bool isCustomer = false;
  bool isContractor = false;

  @override
  void ngAfterViewInit() {
    var bodyClass = window.localStorage['body-class'];

    if (bodyClass == 'compact-nav') {
      querySelector('body').classes.add('compact-nav');
    }
  }
}
