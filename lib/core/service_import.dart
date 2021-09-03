import 'locator.dart';
import 'services/auth_service.dart';
import 'services/dialog_service.dart';
import 'services/navigator_service.dart';
import 'services/sharedprefs_service.dart';

class ServiceImport {
  NavigationService get navigationService => locator<NavigationService>();
  DialogService get dialogService => locator<DialogService>();
  SharedPrefsService get sharedPrefsService => locator<SharedPrefsService>();
  AuthService get authService => locator<AuthService>();
}
