import 'dart:html';
import 'dart:math';
import 'package:angular2/core.dart';

import 'breadcrumb/breadcrumb_component.dart';
import 'sidebar/sidebar_component.dart';
import 'aside/aside_component.dart';
import 'shared/aside_toggler_directive.dart';
import 'shared/navbar_toggler_directive.dart';

@Component(selector: 'master-layout')
@View(templateUrl: 'master_layout_component.html', directives: const [
  BreadcrumbComponent,
  SidebarComponent,
  AsideComponent,
  NavBarTooglerDirective,
  AsideTogglerDirective])
class MasterLayoutComponent implements AfterViewInit {
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
