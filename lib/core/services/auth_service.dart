import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants.dart';
import '../models/dialog_model.dart';
import '../routes/router_path.dart';
import '../service_import.dart';
import 'api/endpoints.dart';

class AuthService extends ServiceImport {
  String? _userToken;
  String? get userToken => this._userToken;

  Future getUserToken() async {
    print("called AuthService:getUserToken");
    _userToken = await sharedPrefsService!.read(Constants.sharedPrefsToken);
  }

  Future signInUser(String? emailId, String? password) async {
    print("called AuthService:signInUser");
    try {
      Uri url = Endpoints.isDev
          ? Uri.http(Endpoints.localhost, Endpoints.signInPost)
          : Uri.https(Endpoints.herokuServer, Endpoints.signInPost);

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
    String? name,
    String? email,
    String? password,
    String type,
  ) async {
    print("called AuthService:signUpUser");
    try {
      Uri url = Endpoints.isDev
          ? Uri.http(Endpoints.localhost, Endpoints.signUpPost)
          : Uri.https(Endpoints.herokuServer, Endpoints.signUpPost);

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

  void logout() async {
    print("called AuthService:logout");

    dialogService!.showLoadingDialog();

    AlertResponse _dialogRes = await dialogService!.showDialog(
        title: "Logout.",
        description: "Are you sure you want to logout?",
        showNegativeButton: true,
        buttonNegativeTitle: "No",
        buttonTitle: "Yes");

    if (_dialogRes.confirmed!) {
      sharedPrefsService!.clear();
      navigationService!.popEverythingAndNavigateTo(kHomeScreen);
    }

    dialogService!.dialogDismiss();
  }
}
