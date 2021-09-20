import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/busDetail_model.dart';
import '../models/bus_model.dart';
import '../models/stops_model.dart';
import '../service_import.dart';
import 'api/endpoints.dart';

class BusService extends ServiceImport {
  Stops _stops;
  Stops get stops => this._stops;

  BusModel _busModel;
  BusModel get busModel => this._busModel;

  Future getAllStops() async {
    print("called BusService:getAllStops");

    try {
      Uri url = Uri.https(Endpoints.herokuServer, Endpoints.getAllStops);

      var response = await http.get(url);

      print("Response in BusService:getAllStops: " + response.body.toString());

      _stops = stopsFromJson(response.body);
    } catch (e) {
      print("Error in BusService:getAllStops: " + e.toString());

      _stops = Stops(success: false);
    }
  }

  Future<BusModel> searchBusBySourceAndDestination({
    String sourceId,
    String destinationId,
  }) async {
    print("called BusService:searchBusBySourceAndDestination");

    try {
      Uri url = Uri.https(
          Endpoints.herokuServer, Endpoints.searchBusBySourceAndDestination);

      var response = await http.post(url,
          body: {"sourceID": "$sourceId", "destinationID": "$destinationId"});

      print("Response in BusService:searchBusBySourceAndDestination: " +
          response.body.toString());

      BusModel _busModel = busFromJson(response.body);
      return _busModel;
    } catch (e) {
      print("Error in BusService:searchBusBySourceAndDestination: " +
          e.toString());

      return BusModel(success: false);
    }
  }

  Future getAllBusList() async {
    print("called BusService:getAllBusList");
    try {
      Uri url = Uri.https(Endpoints.herokuServer, Endpoints.getAllBuses);

      var response = await http.get(url);

      print(
          "Response in BusService:getAllBusList: " + response.body.toString());

      _busModel = busFromJson(response.body);
    } catch (e) {
      print("Error in BusService:getAllBusList: " + e.toString());

      _busModel = BusModel(success: false);
    }
  }

  Future<BusDetailModel> getBusDetail(String busId) async {
    print("called BusService:getBusDetail");
    try {
      Uri url =
          Uri.https(Endpoints.herokuServer, Endpoints.getBusDetail + "/$busId");

      var response = await http.get(url,
          headers: {"Authorization": "Bearer ${authService.userToken}"});

      print("Response in BusService:getBusDetail: " + response.body.toString());

      BusDetailModel _busDetailModel = busDetailModelFromJson(response.body);

      return _busDetailModel;
    } catch (e) {
      print("Error in BusService:getBusDetail: " + e.toString());

      return BusDetailModel(success: false);
    }
  }

  Future createStop(String stopName, String stopCity) async {
    print("called BusService:createStop with $stopName - $stopCity");
    try {
      Uri url = Uri.https(Endpoints.herokuServer, Endpoints.createStopPost);

      var response = await http.post(url,
          body: {"stopName": "$stopName", "stopCity": "$stopCity"},
          headers: {"Authorization": "Bearer ${authService.userToken}"});

      print("Response in BusService:createStop: " + response.body.toString());

      Map<String, dynamic> resp = jsonDecode(response.body);

      return resp;
    } catch (e) {
      print("Error in BusService:createStop: " + e.toString());
      Map<String, dynamic> resp = {"success": false};
      return resp;
    }
  }
}
