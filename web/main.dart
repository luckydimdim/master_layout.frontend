import 'dart:core';

import 'package:alert/src/alert_service.dart';
import 'package:angular2/platform/browser.dart';
import 'package:angular2/platform/common.dart';

import 'package:angular2/core.dart';

import 'package:http/http.dart';
import 'package:http/browser_client.dart';

import 'package:aside/aside_service.dart';
import 'package:auth/auth_service.dart';
import 'package:master_layout/master_layout_component.dart';

import 'package:angular2/router.dart';

import 'package:config/config_service.dart';

bool get isDebug =>
    (const String.fromEnvironment('PRODUCTION', defaultValue: 'false')) !=
    'true';

main() async {
  ComponentRef ref = await bootstrap(MasterLayoutComponent, [
    ROUTER_PROVIDERS,
    const Provider(LocationStrategy, useClass: HashLocationStrategy),
    const Provider(AlertService),
    const Provider(AsideService),
    const Provider(AuthenticationService),
    const Provider(AuthorizationService),
    const Provider(ConfigService),
    provide(Client, useFactory: () => new BrowserClient(), deps: [])
  ]);

  if (isDebug) {
    print('Application in DebugMode');
    enableDebugTools(ref);
  }
}
