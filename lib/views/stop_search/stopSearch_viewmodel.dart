import 'package:BusTracking_App/core/models/stops_model.dart';
import 'package:BusTracking_App/core/service_import.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class StopSearchScreenViewModel extends BaseViewModel with ServiceImport {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Stops _stops;
  Stops get stops => this._stops;

  List<StopsData> _stopsDataListMain;

  List<StopsData> _stopsDataList;
  List<StopsData> get stopsDataList => this._stopsDataList;

  TextEditingController searchTextController = TextEditingController();
  FocusNode searchFN = FocusNode();

  void initializeScreen(StopsData screenData) async {
    setBusy(true);
    // print("GOT: " + screenData.id?.toString() ?? "ASD");
    _stops = busService.stops;
    if (_stops.success) {
      _stopsDataList = _stops.data;
      _stopsDataListMain = _stops.data;
    } else {
      _stopsDataList = [];
    }
    setBusy(false);
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

  void handleStopTap(StopsData _selectedStop) {
    navigationService.pop(arguments: _selectedStop);
  }
}
