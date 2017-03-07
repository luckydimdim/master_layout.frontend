import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:angular2/platform/common.dart' as Common;

class BreadcrumbData {
  String displayName;
  String url;
}

@Component(selector: 'breadcrumb')
@View(templateUrl: 'breadcrumb_component.html')
class BreadcrumbComponent
    implements AfterViewInit {
  final Router _router;
  final ChangeDetectorRef _changeDetectorRef;
  Common.Location _location;

  Map<Type, BreadcrumbData> items = new Map<Type, BreadcrumbData>();

  BreadcrumbComponent(this._changeDetectorRef, this._router, this._location) {}

  @override
  void ngAfterViewInit() {
    _buildBreadcrumbs(this._router.currentInstruction);

    this._router.root.subscribe((e) {
      this._router.recognize(e).then((i) {
        _buildBreadcrumbs(i);
      });
    });
  }

  void _buildBreadcrumbs(Instruction instruction) {
    if (instruction == null)
      return;

    items.clear();

    var current_instruction = instruction;

    items[current_instruction.component.componentType] =
        getData(current_instruction);

    while (current_instruction.child != null) {
      current_instruction = current_instruction.child;

      items[current_instruction.component.componentType] =
          getData(current_instruction);
    }

    _changeDetectorRef.detectChanges();
  }

  BreadcrumbData getData(Instruction instruction) {
    var result = new BreadcrumbData();

    /*
    * TODO: Формирование ссылки
    * result.url = this._location.prepareExternalUrl(_router.generate([instruction.component.routeName]).toLinkUrl());
    * */
    result.url = '#';

    if (instruction.component.routeData != null) {
      result.displayName = instruction.component.routeData.data['displayName'];
    }

    if (result.displayName == null)
      result.displayName = instruction.component.routeName;

    return result;
  }

}
