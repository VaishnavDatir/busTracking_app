import 'package:http/http.dart' as http;

import '../models/userDetails_model.dart';
import '../service_import.dart';
import 'api/endpoints.dart';

class UserService extends ServiceImport {
  UserDetails _userDetails;
  UserDetails get userDetails => this._userDetails;

  Future getUserData() async {
    print("called AuthService:getUserData");

    try {
      Uri url = Uri.https(Endpoints.herokuServer, Endpoints.getUserData);

      var response = await http.get(url, headers: {
        'Authorization': 'Bearer ${authService.userToken}',
        'Content-Type': 'application/json'
      });

      print("Response in AuthService:getUserData: " + response.body.toString());

      _userDetails = userDetailsFromJson(response.body);
    } catch (e) {
      print("Error in AuthService:getUserData: " + e.toString());

      _userDetails = UserDetails(
          success: false,
          message: "There was an error while getting data try again later");
    }
  }
}
