import 'package:BusTracking_App/core/models/stops_model.dart';
import 'package:BusTracking_App/core/service_import.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import 'api/endpoints.dart';

class BusService extends ServiceImport {
  Stops _stops;
  Stops get stops => this._stops;

  Future getAllStops() async {
    print("called BusService:getAllStops");

    try {
      Uri url = Uri.http(Endpoints.localhost, Endpoints.getAllStops);

      var response = await http.get(
        url,
      );

      print("Response in BusService:getAllStops: " + response.body.toString());

      _stops = stopsFromJson(response.body);
    } catch (e) {
      _stops = Stops(success: false);
    }
  }
}
