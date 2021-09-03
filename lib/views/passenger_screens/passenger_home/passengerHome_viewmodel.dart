import 'package:BusTracking_App/core/service_import.dart';
import 'package:stacked/stacked.dart';

class PassengerViewModel extends BaseViewModel with ServiceImport {
  initializeScreen() async {
    setBusy(true);

    setBusy(false);
  }
}
