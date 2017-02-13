import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

@Component(selector: 'master-layout')
@View(
    templateUrl: 'master_layout_component.html',
    directives: const [RouterLink])
class MasterLayoutComponent {}