import 'locator.dart';
// import 'services/backend_service.dart';
import 'services/dialog_service.dart';
import 'services/navigator_service.dart';

class ServiceImport {
  NavigationService get navigationService => locator<NavigationService>();
  DialogService get dialogService => locator<DialogService>();
  // BackendService get backendService => locator<BackendService>();
}
