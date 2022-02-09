import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../../core/service_import.dart';
import '../components/setup_dialog_ui.dart';

class AddStopViewModel extends BaseViewModel with ServiceImport {
  TextEditingController stopNameController = TextEditingController();
  TextEditingController stopCityController = TextEditingController();

  Map<String, dynamic>? _response;
  Map<String, dynamic>? get response => this._response;

  addStop() async {
    dialogService.showCustomDialog(variant: DialogType.loading);

    String stopName = stopNameController.text.toString().trim();
    String stopCity = stopCityController.text.toString().trim();

    if (stopName.isNotEmpty && stopCity.isNotEmpty) {
      _response = await busService.createStop(stopName, stopCity);

      if (_response!["success"]) {
        await busService.getAllStops();
      }

      await dialogService.showDialog(
          title: _response!["success"] ? "Success" : "Oops!",
          description: _response!["message"].toString());

      navigationService.back();
    } else {
      await dialogService.showDialog(
          description: "Please fill the information correctly");
    }

    navigationService.back();
  }
}
