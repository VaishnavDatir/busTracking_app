import 'dart:developer';

import 'package:BusTracking_App/core/models/stops_model.dart';
import 'package:BusTracking_App/core/routes/router_path.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../core/service_import.dart';

class CreateBusViewModel extends BaseViewModel with ServiceImport {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController scrollController = ScrollController();

  final TextEditingController busNoTEC = TextEditingController();
  final FocusNode busNoFN = FocusNode();

  final TextEditingController busProviderTEC = TextEditingController();
  final FocusNode busProviderFN = FocusNode();

  final TextEditingController busTypeTEC = TextEditingController();
  final FocusNode busTypeFN = FocusNode();

  List<String> _busTimingList = [];
  List<String> get busTimingList => this._busTimingList;

  List<StopsData> _busRouteList = [];
  List<StopsData> get busRouteList => this._busRouteList;

  List<Step> step = [];

  addTiming(BuildContext context) async {
    FocusScope.of(scaffoldKey.currentContext).unfocus();

    final TimeOfDay pickedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (pickedTime != null) {
      final DateTime now = new DateTime.now();

      final dt = DateTime(
          now.year, now.month, now.day, pickedTime.hour, pickedTime.minute);

      final format = DateFormat.Hm();
      final selectedTime = format.format(dt);

      // print(selectedTime.toString());

      if (_busTimingList.contains(selectedTime)) {
        await dialogService.showDialog(
            description: "${selectedTime.toString()} is already added!");
      } else {
        _busTimingList.add(selectedTime);
        _busTimingList.sort();
      }
    }
    notifyListeners();
  }

  removeTiming(int index) async {
    dialogService.showLoadingDialog();
    _busTimingList.removeAt(index);
    notifyListeners();
    dialogService.dialogDismiss();
  }

  addRoute() async {
    FocusScope.of(scaffoldKey.currentContext).unfocus();

    StopsData _selectedStop =
        await navigationService.navigateTo(kStopSearchScreen);

    if (_selectedStop != null) {
      // print(_selectedStop.id);

      if (_busRouteList.contains(_selectedStop)) {
        await dialogService.showDialog(
            description:
                "${_selectedStop.stopName}, ${_selectedStop.stopCity} is already added!}");
      } else {
        _busRouteList.add(_selectedStop);
      }
    }
    notifyListeners();

    scrollController.animateTo(scrollController.position.maxScrollExtent + 85,
        duration: Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  removeStop(int index) async {
    StopsData _lastStopRemoved = _busRouteList[index];
    _busRouteList.removeAt(index);

    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('${_lastStopRemoved.stopName} removed!'),
      duration: Duration(seconds: 1),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          _busRouteList.insert(index, _lastStopRemoved);
          notifyListeners();
        },
      ),
    ));
    notifyListeners();
  }

  createBus() async {
    dialogService.showLoadingDialog();

    var response = await busService.createBus(
      busNoTEC.text.toString().trim(),
      busTypeTEC.text.toString().trim(),
      busProviderTEC.text.toString().trim(),
      _busTimingList,
      _busRouteList,
    );

    if (response["success"]) {
      await busService.getAllBusList();
      await dialogService.showDialog(
          title: "Success",
          description:
              "Bus no. ${busNoTEC.text.toString().trim()} has been added");
      navigationService.pop();
    } else {
      await dialogService.showDialog(
          title: "Oh ho!",
          description:
              "${busNoTEC.text.toString().trim()} has could not be added");
    }

    dialogService.dialogDismiss();
  }
}
