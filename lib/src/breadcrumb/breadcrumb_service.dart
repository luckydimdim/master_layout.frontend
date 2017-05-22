import 'package:angular2/core.dart';

class BreadcrumbDataChangedEvent {
  Type type;
  String displayName;
}

@Injectable()
class BreadcrumbService {

  EventEmitter<BreadcrumbDataChangedEvent>onDataChangedEvent = new EventEmitter();

  void changeDisplayName(Type type, String displayName) {
    var event = new BreadcrumbDataChangedEvent()
        ..type = type
        ..displayName = displayName;

    onDataChangedEvent.emit(event);
  }
}