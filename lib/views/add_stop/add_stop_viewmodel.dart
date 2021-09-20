import 'package:BusTracking_App/core/service_import.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class AddStopViewModel extends BaseViewModel with ServiceImport {
  TextEditingController stopNameController = TextEditingController();
  TextEditingController stopCityController = TextEditingController();

  Map<String, dynamic> _response;
  Map<String, dynamic> get response => this._response;

  addStop() async {
    dialogService.showLoadingDialog();

    String stopName = stopNameController.text.toString().trim();
    String stopCity = stopCityController.text.toString().trim();

    if (stopName.isNotEmpty && stopCity.isNotEmpty) {
      _response = await busService.createStop(stopName, stopCity);

      if (_response["success"]) {
        await busService.getAllStops();
      }

      await dialogService.showDialog(
          title: _response["success"] ? "Success" : "Oops!",
          description: _response["message"].toString());

      navigationService.pop();
    } else {
      await dialogService.showDialog(
          description: "Please fill the information correctly");
    }

    dialogService.dialogDismiss();
  }
}
