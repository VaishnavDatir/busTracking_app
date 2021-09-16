import 'package:stacked/stacked.dart';

import '../../core/models/busDetail_model.dart';
import '../../core/service_import.dart';

class BusDetailViewModel extends BaseViewModel with ServiceImport {
  BusDetailModel _busDetailModel;
  BusDetailModel get busDetailModel => this._busDetailModel;

  BusDetailData _busDetailData;
  BusDetailData get busDetailData => this._busDetailData;

  String sourceStopId;
  String destinationStopId;

  initializeScreen(Map<String, dynamic> screenDetails) async {
    setBusy(true);

    String busId = screenDetails["busId"];
    _busDetailModel = await busService.getBusDetail(busId);

    if (_busDetailModel.success) {
      _busDetailData = _busDetailModel.busDetailData;
    }

    sourceStopId = screenDetails["sourceStop"] ?? null;
    destinationStopId = screenDetails["destinationStop"] ?? null;

    setBusy(false);
    notifyListeners();
  }

  fabReverseRoute() {
    _busDetailData.busStops = _busDetailData.busStops.reversed.toList();
    notifyListeners();
  }
}
