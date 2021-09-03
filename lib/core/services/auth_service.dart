import 'dart:convert';

import 'package:BusTracking_App/core/constants.dart';
import 'package:BusTracking_App/core/models/userDetails_model.dart';
import 'package:BusTracking_App/core/routes/router_path.dart';
import 'package:BusTracking_App/core/service_import.dart';
import 'package:http/http.dart' as http;

import 'api/endpoints.dart';

class AuthService extends ServiceImport {
  Future signInUser(String emailId, String password) async {
    print("called AuthService:signInUser");
    try {
      Uri url = Uri.http(Endpoints.localhost, Endpoints.signInPost);

      var res = await http.post(url, body: {
        "email": "$emailId",
        "password": "$password",
      });

      var jsonResponse = jsonDecode(res.body);

      print("Response in AuthService:signInUser: " + jsonResponse.toString());

      return jsonResponse;
    } catch (e) {
      print("Error in AuthService:signInUser:: " + e.toString());

      Map<String, dynamic> res = {
        "success": false,
        "message": "Something went wrong. Let's try again!"
      };

      return res;
    }
  }

  Future signUpUser(
    String name,
    String email,
    String password,
    String type,
  ) async {
    print("called AuthService:signUpUser");
    try {
      Uri url = Uri.http(Endpoints.localhost, Endpoints.signUpPost);

      var res = await http.post(url, body: {
        "name": "$name",
        "email": "$email",
        "password": "$password",
        "type": "$type"
      });

      var jsonResponse = jsonDecode(res.body);

      print("Response in AuthService:signUpUser: " + jsonResponse.toString());

      return jsonResponse;
    } catch (e) {
      print("Error in AuthService:signUpUser: " + e.toString());

      Map<String, dynamic> res = {
        "success": false,
        "message": "Something went wrong. Let's try again!"
      };

      return res;
    }
  }

  logout() {
    dialogService.showLoadingDialog();
    sharedPrefsService.clear();
    navigationService.popEverythingAndNavigateTo(kHomeScreen);
    dialogService.dialogDismiss();
  }

  Future getUserData() async {
    print("called AuthService:getUserData");

    try {
      Uri url = Uri.http(Endpoints.localhost, Endpoints.getUserData);
      String token = sharedPrefsService.read(Constants.sharedPrefsToken);

      var response =
          await http.get(url, headers: {'Authorization': 'Bearer $token'});

      print("Response in AuthService:getUserData: " + response.body.toString());

      UserDetails _userDetails = userDetailsFromJson(response.body);
      return _userDetails;
    } catch (e) {
      print("Error in AuthService:getUserData: " + e.toString());

      UserDetails res = UserDetails(
          success: false,
          message: "There was an error while getting data try again later");

      return res;
    }
  }
}
