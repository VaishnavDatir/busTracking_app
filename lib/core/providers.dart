import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../core/locator.dart';
import '../core/services/navigator_service.dart';
import 'locator.dart';
import 'service_import.dart';
import 'services/auth_service.dart';
import 'services/dialog_service.dart';
import 'services/sharedprefs_service.dart';

class ProviderInjector {
  static List<SingleChildWidget> providers = [
    Provider.value(value: locator<NavigationService>()),
    Provider.value(value: locator<SharedPrefsService>()),
    Provider.value(value: locator<DialogService>()),
    Provider.value(value: locator<ServiceImport>()),
    Provider.value(value: locator<AuthService>()),
  ];
}
