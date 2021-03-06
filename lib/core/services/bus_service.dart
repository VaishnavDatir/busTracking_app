import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/busDetail_model.dart';
import '../models/bus_model.dart';
import '../models/stops_model.dart';
import '../service_import.dart';
import 'api/endpoints.dart';

class BusService extends ServiceImport {
  Stops? _stops;
  Stops? get stops => this._stops;

  BusModel? _busModel;
  BusModel? get busModel => this._busModel;

  Future getAllStops() async {
    print("called BusService:getAllStops");

    try {
      Uri url = Endpoints.isDev
          ? Uri.http(Endpoints.localhost, Endpoints.getAllStops)
          : Uri.https(Endpoints.herokuServer, Endpoints.getAllStops);

      var response = await http.get(url);

      print("Response in BusService:getAllStops: " + response.body.toString());

      _stops = stopsFromJson(response.body);
    } catch (e) {
      print("Error in BusService:getAllStops: " + e.toString());

      _stops = Stops(success: false);
    }
  }

  Future<BusModel> searchBusBySourceAndDestination({
    String? sourceId,
    String? destinationId,
  }) async {
    print("called BusService:searchBusBySourceAndDestination");

    try {
      Uri url = Endpoints.isDev
          ? Uri.http(
              Endpoints.localhost, Endpoints.searchBusBySourceAndDestination)
          : Uri.https(Endpoints.herokuServer,
              Endpoints.searchBusBySourceAndDestination);

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
      Uri url = Endpoints.isDev
          ? Uri.http(Endpoints.localhost, Endpoints.getAllBuses)
          : Uri.https(Endpoints.herokuServer, Endpoints.getAllBuses);

      var response = await http.get(url);

      print(
          "Response in BusService:getAllBusList: " + response.body.toString());

      _busModel = busFromJson(response.body);
    } catch (e) {
      print("Error in BusService:getAllBusList: " + e.toString());

      _busModel = BusModel(success: false);
    }
  }

  Future<BusDetailModel> getBusDetail(String? busId) async {
    print("called BusService:getBusDetail");
    try {
      Uri url = Endpoints.isDev
          ? Uri.http(Endpoints.localhost, Endpoints.getBusDetail + "/$busId")
          : Uri.https(
              Endpoints.herokuServer, Endpoints.getBusDetail + "/$busId");

      var response = await http.get(url, headers: {
        "Authorization": "Bearer ${authService.userToken}",
        'Content-Type': 'application/json'
      });

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
      Uri url = Endpoints.isDev
          ? Uri.http(Endpoints.localhost, Endpoints.createStopPost)
          : Uri.https(Endpoints.herokuServer, Endpoints.createStopPost);

      var bodyData = json.encode({"stopName": stopName, "stopCity": stopCity});
      var response = await http.post(url, body: bodyData, headers: {
        "Authorization": "Bearer ${authService.userToken}",
        'Content-Type': 'application/json'
      });

      print("Response in BusService:createStop: " + response.body.toString());

      Map<String, dynamic>? resp = jsonDecode(response.body);

      return resp;
    } catch (e) {
      print("Error in BusService:createStop: " + e.toString());
      Map<String, dynamic> resp = {"success": false};
      return resp;
    }
  }

  Future createBus(
    String busNumber,
    String busType,
    String busProvider,
    List busTimings,
    List busStops,
    int busSittingCap,
  ) async {
    print("called BusService:createBus with $busNumber");
    try {
      Uri url = Endpoints.isDev
          ? Uri.http(Endpoints.localhost, Endpoints.createBusPost)
          : Uri.https(Endpoints.herokuServer, Endpoints.createBusPost);

      var bodyData = json.encode({
        "busNumber": busNumber,
        "busType": busType,
        "busProvider": busProvider,
        "busTimings": busTimings,
        "busStops": busStops,
        "sittingCap": busSittingCap
      });

      var response = await http.post(
        url,
        body: bodyData,
        headers: {
          "Authorization": "Bearer ${authService.userToken}",
          'Content-Type': 'application/json'
        },
      );

      print("Response in BusService:createBus: " + response.body.toString());

      Map<String, dynamic>? resp = jsonDecode(response.body);

      return resp;
    } catch (e) {
      print("Error in BusService:createBus " + e.toString());
      Map<String, dynamic> resp = {"success": false};
      return resp;
    }
  }
}
