import "package:angular2/core.dart" show Directive;
import 'package:angular2/router.dart';
import "package:angular2/platform/common.dart" show Location;

/*
* По сути - копия RouterLink с переделанным методом _updateLink
* При отсутствии RouteConfig вместо исключения подставляется ссылка #_this
* с предупреждением в консоли
* */

@Directive(selector: "[cmRouterLink]", inputs: const [
  "routeParams: cmRouterLink",
  "target: target"
], host: const {
  "(click)": "onClick()",
  "[attr.href]": "visibleHref",
  "[class.active]": "isRouteActive"
})
class CmRouterLink {
  Router _router;
  Location _location;

  // the url displayed on the anchor element.
  String visibleHref;
  String target;
  static String unknownHref = '#_this';
  List<dynamic> _routeParams;

  // the instruction passed to the router to navigate
  Instruction _navigationInstruction;

  CmRouterLink(this._router, this._location) {
    // we need to update the link whenever a route changes to account for aux routes
    this._router.subscribe((_) => this._updateLink());
  }

  // because auxiliary links take existing primary and auxiliary routes into account,

  // we need to update the link whenever params or other routes change.
  void _updateLink() {
    try {
      this._navigationInstruction = this._router.generate(this._routeParams);
      var navigationHref = this._navigationInstruction.toLinkUrl();
      this.visibleHref = this._location.prepareExternalUrl(navigationHref);
    } catch (ex) {
      print('cmRouterLink(${this
          ._routeParams}):  $ex ... using $unknownHref href');
      this.visibleHref = unknownHref;
    }
  }

  bool get isRouteActive {
    return this._router.isRouteActive(this._navigationInstruction);
  }

  set routeParams(List<dynamic> changes) {
    this._routeParams = changes;
    this._updateLink();
  }

  bool onClick() {
    // If no target, or if target is _self, prevent default browser behavior
    if (this.target is! String || this.target == "_self") {
      this._router.navigateByInstruction(this._navigationInstruction);
      return false;
    }
    return true;
  }
}
