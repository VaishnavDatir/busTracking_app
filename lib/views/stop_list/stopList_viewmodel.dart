import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../core/models/stops_model.dart';
import '../../core/routes/router_path.dart';
import '../../core/service_import.dart';

class StopListViewModel extends BaseViewModel with ServiceImport {
  Stops _stops;
  Stops get stops => this._stops;

  List<StopsData> _stopsDataList;
  List<StopsData> get stopsDataList => this._stopsDataList;

  List<StopsData> _stopsDataListMain;
  TextEditingController searchTextController = TextEditingController();

  initializeScreen() {
    _stops = busService.stops;

    if (stops.success) {
      _stopsDataList = stops.data;
      _stopsDataListMain = _stops.data;
    }
    notifyListeners();
  }

  refreshStopList() async {
    await busService.getAllStops();
    initializeScreen();
    notifyListeners();
  }

  void filterSearchResults(String query) async {
    List<StopsData> searchList = [];

    searchList = _stopsDataListMain;

    if (query.trim().isNotEmpty) {
      List<StopsData> localListData = [];
      searchList.forEach((StopsData element) {
        if ((element.stopName.toLowerCase().contains(query.toLowerCase())) ||
            (element.stopCity.toLowerCase().contains(query.toLowerCase()))) {
          localListData.add(element);
        }
      });

      _stopsDataList = localListData.toSet().toList();
    } else {
      resetSearchResults();
    }

    notifyListeners();
  }

  void resetSearchResults() {
    _stopsDataList = _stopsDataListMain;
    notifyListeners();
  }

  addstop() async {
    await navigationService.navigateTo(kAddStopScreen);
    initializeScreen();
  }
}
