import '../../app/app.router.dart';
import 'package:stacked/stacked.dart';

import '../../core/models/busDetail_model.dart';
import '../../core/service_import.dart';
import '../components/setup_dialog_ui.dart';

class BusDetailViewModel extends BaseViewModel with ServiceImport {
  BusDetailModel? _busDetailModel;
  BusDetailModel? get busDetailModel => this._busDetailModel;

  BusDetailData? _busDetailData;
  BusDetailData? get busDetailData => this._busDetailData;

  String? sourceStopId;
  String? destinationStopId;

  late bool driverGoingOnDuty;

  String? busId;

  initializeScreen(Map<String, dynamic> screenDetails) async {
    setBusy(true);

    busId = screenDetails["busId"];
    driverGoingOnDuty = screenDetails["driverGoingOnDuty"] ?? false;

    _busDetailModel = await busService.getBusDetail(busId);

    if (_busDetailModel!.success!) {
      _busDetailData = _busDetailModel!.busDetailData;
    }

    sourceStopId = screenDetails["sourceStop"] ?? null;
    destinationStopId = screenDetails["destinationStop"] ?? null;

    notifyListeners();
    setBusy(false);
  }

  fabReverseRoute() {
    _busDetailData!.busStops = _busDetailData!.busStops!.reversed.toList();
    notifyListeners();
  }

  setDriverForBus() async {
    dialogService.showCustomDialog(variant: DialogType.loading);

    Map<String, dynamic> response =
        await (userService.updateUserIsActive(true));

    if (response["success"]) {
      Map<String, dynamic> response1 =
          await (userService.setDriverOnBus(busId));

      // await locationService.getAndShareLiveLocation(response1["data"]);
      await locationService.startService(response1['data']);
      await userService.getUserData();

      await dialogService.showDialog(
          title: response1["success"].toString(),
          description: response1["message"]);

      // navigationService!.popEverythingAndNavigateTo(kDriverHomeScreen);
      navigationService.clearStackAndShow(Routes.driverHomeScreen);
    } else {
      await dialogService.showDialog(
          description:
              "There was an error while assiging bus for you. Try again later");
    }

    navigationService.back();
  }
}
