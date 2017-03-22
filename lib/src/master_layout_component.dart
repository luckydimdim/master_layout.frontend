import 'dart:html';
import 'dart:math';
import 'package:angular2/core.dart';

import 'breadcrumb/breadcrumb_component.dart';
import 'sidebar/sidebar_component.dart';
import 'package:aside/aside_component.dart';
import 'package:aside/aside_service.dart';
import 'shared/aside_toggler_directive.dart';
import 'shared/navbar_toggler_directive.dart';
import 'package:alert/alert_component.dart';
import 'package:angular2/router.dart';

@Component(selector: 'master-layout', providers: const [const Provider(AsideService, useClass: AsideService)])
@View(templateUrl: 'master_layout_component.html', directives: const [
  AlertComponent,
  BreadcrumbComponent,
  SidebarComponent,
  AsideComponent,
  NavBarTooglerDirective,
  AsideTogglerDirective])
class MasterLayoutComponent implements AfterViewInit {
    Router _router;

  MasterLayoutComponent(this._router) {
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
}
