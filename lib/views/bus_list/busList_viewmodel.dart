import 'package:BusTracking_App/core/models/bus_model.dart';
import 'package:BusTracking_App/core/routes/router_path.dart';
import 'package:BusTracking_App/core/service_import.dart';
import 'package:stacked/stacked.dart';

class BusListViewModel extends BaseViewModel with ServiceImport {
  BusModel _busModel;
  BusModel get busModel => this._busModel;

  List<BusModelData> _busModelData;
  List<BusModelData> get busModelData => this._busModelData;

  initializeScreen() async {
    _busModel = busService.busModel;
    if (_busModel.success) {
      _busModelData = _busModel.data;
    }
    notifyListeners();
  }

  handleOnBusTap(String busId) {
    navigationService.navigateTo(kBusDetailScreen, arguments: {
      "busId": busId,
    });
  }
}
