import 'dart:html';
import 'dart:math';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:auth/auth_service.dart';
import 'breadcrumb/breadcrumb_component.dart';
import 'user_info_model.dart';
import 'sidebar/sidebar_component.dart';
import 'package:aside/aside_component.dart';
import 'shared/aside_toggler_directive.dart';
import 'shared/navbar_toggler_directive.dart';
import 'package:alert/alert_component.dart';


import 'breadcrumb/breadcrumb_service.dart';

@Component(selector: 'master-layout', providers: const [ const Provider(BreadcrumbService, useClass: BreadcrumbService) ])
@View(
  templateUrl: 'master_layout_component.html',
  directives: const [
    AlertComponent,
    BreadcrumbComponent,
    SidebarComponent,
    AsideComponent,
    NavBarTooglerDirective,
    AsideTogglerDirective])
class MasterLayoutComponent implements AfterViewInit {
  final AuthenticationService _authenticationService;
  final AuthorizationService _authorizationService;
    final Router _router;

    UserInfoModel userInfoModel = new UserInfoModel();

  MasterLayoutComponent(this._router, this._authenticationService, this._authorizationService) {
    userInfoModel.name = _authenticationService.getUserName();

    if (_authorizationService.getRoles().contains('CUSTOMER')){
      // заказчик
      userInfoModel.avatarUrl = 'packages/master_layout/assets/img/avatars/7.jpg';
    }
    else if (_authorizationService.getRoles().contains('CONTRACTOR')) {
      // подрядчик
      userInfoModel.avatarUrl = 'packages/master_layout/assets/img/avatars/icon-contractor.png';
    }
    else {
      userInfoModel.avatarUrl = 'packages/master_layout/assets/img/avatars/7.jpg';
    }

    _router.root.subscribe((e) {
      window.scrollTo(0, 0);
    });
  }
  
  @override
  void ngAfterViewInit() {
    smartResize();
    window.onResize.listen((Event e) {
      smartResize();
    });
  }

  /**
   * Прибили футер к нижнему краю экрана
   */
  void smartResize() {
    var documentHeight = window.innerHeight;
    var bodyHeight = querySelector('body').clientHeight;
    var menu = querySelector('.sidebar-nav .nav').clientHeight;

    var contentHeight = max(bodyHeight, menu);

    if (documentHeight > contentHeight) {
      querySelector('body').style.minHeight = documentHeight.toString() +'px';
    } else {
      querySelector('body').style.minHeight = contentHeight.toString() +'px';
    }
  }

  void logout() {
    _authenticationService.logout();
    _router.navigateByUrl(_authenticationService.authPath);
  }

}
