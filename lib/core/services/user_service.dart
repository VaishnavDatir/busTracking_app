import 'dart:convert';
import 'dart:ffi';

import 'package:http/http.dart' as http;

import '../models/userDetails_model.dart';
import '../service_import.dart';
import 'api/endpoints.dart';

class UserService extends ServiceImport {
  UserDetails _userDetails;
  UserDetails get userDetails => this._userDetails;

  Future getUserData() async {
    print("called UserService:getUserData");

    try {
      Uri url = Uri.https(Endpoints.herokuServer, Endpoints.getUserData);

      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${authService.userToken}',
          'Content-Type': 'application/json'
        },
      );

      print("Response in UserService:getUserData: " + response.body.toString());

      _userDetails = userDetailsFromJson(response.body);
    } catch (e) {
      print("Error in UserService:getUserData: " + e.toString());

      _userDetails = UserDetails(
          success: false,
          message: "There was an error while getting data try again later");
    }
  }

  Future updateUserIsActive(bool isActive) async {
    print("called UserService:updateUserIsActive");
    try {
      Uri url = Uri.https(Endpoints.herokuServer, Endpoints.updateUserIsActive);

      var bodayData = json.encode({"isActive": isActive});

      http.Response response = await http.post(
        url,
        body: bodayData,
        headers: {
          'Authorization': 'Bearer ${authService.userToken}',
          'Content-Type': 'application/json'
        },
      );

      print("Response in UserService:updateUserIsActive: " +
          response.body.toString());

      var jsonResponse = jsonDecode(response.body);

      return jsonResponse;
    } catch (e) {
      print("Error in UserService:updateUserIsActive: " + e.toString());

      Map<String, dynamic> response = {"success": false};

      return response;
    }
  }

  Future setDriverOnBus(String busId) async {
    print("called UserService:setDriverOnBus");

    try {
      Uri url = Uri.https(Endpoints.herokuServer, Endpoints.setDriverOnBus);

      var bodayData = json.encode({
        "busId": busId,
      });

      http.Response response = await http.post(
        url,
        body: bodayData,
        headers: {
          'Authorization': 'Bearer ${authService.userToken}',
          'Content-Type': 'application/json'
        },
      );

      print("Response in UserService:setDriverOnBus: " +
          response.body.toString());

      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } catch (e) {
      print("Error in UserService:setDriverOnBus: " + e.toString());
      Map<String, dynamic> resp = {
        "success": false,
        "message":
            "There was an error while assiging you a bus. Try again later",
      };

      return resp;
    }
  }

  Future removeDriverOnBus() async {
    print("called UserService:removeDriverOnBus");
    try {
      Uri url = Uri.https(Endpoints.herokuServer, Endpoints.removeDriverOnBus);

      http.Response response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${authService.userToken}',
          'Content-Type': 'application/json'
        },
      );

      print("Response in UserService:removeDriverOnBus: " +
          response.body.toString());

      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } catch (e) {
      print("Error in UserService:removeDriverOnBus: " + e.toString());
      Map<String, dynamic> resp = {
        "success": false,
        "message":
            "There was an error while removing you from a bus. Try again later",
      };

      return resp;
    }
  }

  Future updateUserLocation(Double latitude, Double longitude) async {
    print("called UserService:updateUserLocation");

    try {
      Uri url = Uri.https(Endpoints.herokuServer, Endpoints.updateUserLocation);

      var bodayData = json.encode({
        "latitude": latitude,
        "longitude": longitude,
      });

      http.Response response = await http.post(
        url,
        body: bodayData,
        headers: {
          'Authorization': 'Bearer ${authService.userToken}',
          'Content-Type': 'application/json'
        },
      );

      print("Response in UserService:updateUserLocation: " +
          response.body.toString());
    } catch (e) {
      print("Error in UserService:updateUserLocation: " + e.toString());
    }
  }
}
