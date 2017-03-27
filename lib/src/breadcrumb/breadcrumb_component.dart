import 'dart:async';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:angular2/platform/common.dart' as common;

import 'breadcrumb_service.dart';

class BreadcrumbData {
  String displayName;
  String url;
  Type type;
}

@Component(selector: 'breadcrumb')
@View(templateUrl: 'breadcrumb_component.html')
class BreadcrumbComponent
    implements AfterViewInit, OnInit, OnDestroy {
  final Router _router;
  final ChangeDetectorRef _changeDetectorRef;
  common.Location _location;
  final BreadcrumbService _breadcrumbService;
  StreamSubscription _onDataChangedEventSubscription;

  Map<Type, BreadcrumbData> items = new Map<Type, BreadcrumbData>();

  BreadcrumbComponent(this._changeDetectorRef, this._router, this._location,
      this._breadcrumbService) {}

  @override
  void ngOnInit() {
    _onDataChangedEventSubscription =
        _breadcrumbService.onDataChangedEvent.listen((e) {
          if (items.containsKey(e.type)) {
            items[e.type].displayName = e.displayName;
            _changeDetectorRef.detectChanges();
          }
        });
  }

  @override
  void ngAfterViewInit() {
    _buildBreadcrumbs(this._router.root.currentInstruction);

    this._router.root.subscribe((e) {
      this._router.recognize(e).then((i) {
        _buildBreadcrumbs(i);
      });
    });
  }

  @override
  Future ngOnDestroy() async {
    if (_onDataChangedEventSubscription != null) {
      return _onDataChangedEventSubscription.cancel();
    }
  }

  void _buildBreadcrumbs(Instruction instruction) {
    if (instruction == null)
      return;

    var oldItems = new Map<Type, BreadcrumbData>();
    items.forEach((k, v) {
      oldItems[k] = v;
    });

    items.clear();

    var current_instruction = instruction;

    items[current_instruction.component.componentType] =
        getData(current_instruction);

    while (current_instruction.child != null) {
      current_instruction = current_instruction.child;

      items[current_instruction.component.componentType] =
          getData(current_instruction);
    }

    items.forEach((k, v) {
      if (oldItems.containsKey(k)) {
        items[k].displayName = oldItems[k].displayName;
      }
    });

    _changeDetectorRef.detectChanges();
  }

  BreadcrumbData getData(Instruction instruction) {
    var result = new BreadcrumbData();

    /*
    * TODO: Формирование ссылки
    * result.url = this._location.prepareExternalUrl(_router.generate([instruction.component.routeName]).toLinkUrl());
    * */
    result.url = '#';

    result.type = instruction.component.runtimeType;

    if (instruction.component.routeData != null) {
      result.displayName = instruction.component.routeData.data['displayName'];
    }

    if (result.displayName == null)
      result.displayName = instruction.component.routeName;

    return result;
  }

  trackByFn(index, item) {
    return item.runtimeType.toString();
  }

}
