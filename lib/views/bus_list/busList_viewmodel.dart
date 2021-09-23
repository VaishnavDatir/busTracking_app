import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../core/models/bus_model.dart';
import '../../core/routes/router_path.dart';
import '../../core/service_import.dart';

class BusListViewModel extends BaseViewModel with ServiceImport {
  BusModel _busModel;
  BusModel get busModel => this._busModel;

  List<BusModelData> _busModelData;
  List<BusModelData> get busModelData => this._busModelData;

  List<BusModelData> _busDataListMain;

  TextEditingController searchTextController = TextEditingController();

  initializeScreen() async {
    _busModel = busService.busModel;
    if (_busModel.success) {
      _busDataListMain = busModel.data;

      _busModelData = _busModel.data;
    }
    notifyListeners();
  }

  handleOnBusTap(String busId) {
    navigationService.navigateTo(kBusDetailScreen, arguments: {
      "busId": busId,
    });
  }

  void filterSearchResults(String query) async {
    List<BusModelData> searchList = [];

    searchList = _busDataListMain;

    if (query.trim().isNotEmpty) {
      List<BusModelData> localListData = [];
      searchList.forEach((BusModelData element) {
        if ((element.busNumber.toLowerCase().contains(query.toLowerCase())) ||
            (element.busType.toLowerCase().contains(query.toLowerCase()))) {
          localListData.add(element);
        }
      });

      _busModelData = localListData.toSet().toList();
    } else {
      resetSearchResults();
    }

    notifyListeners();
  }

  void resetSearchResults() {
    _busModelData = _busDataListMain;
    notifyListeners();
  }

  void addBuss() async {
    await navigationService.navigateTo(kAddBusScreen);
    initializeScreen();
  }

  doRefresh() async {
    await busService.getAllBusList();
    initializeScreen();
  }
}
