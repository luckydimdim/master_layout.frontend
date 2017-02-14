import 'dart:html';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'cm_router_link.dart';

@Component(selector: 'master-layout')
@View(
    templateUrl: 'master_layout_component.html',
    directives: const [CmRouterLink])
class MasterLayoutComponent implements AfterViewInit {
  @override
  void ngAfterViewInit() {
    var script = new ScriptElement()
      ..async = true
      ..type = 'text/javascript'
      ..src = 'packages/master_layout/assets/js/app.js';
    document.body.append(script);
  }
}