import 'package:BusTracking_App/core/service_import.dart';
import 'package:stacked/stacked.dart';

class AddStopViewModel extends BaseViewModel with ServiceImport {
  addStop(String stopName, String stopCity) async {
    busService.createStop(stopName, stopCity);
  }
}
