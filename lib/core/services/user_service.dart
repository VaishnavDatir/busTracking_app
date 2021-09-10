import 'package:http/http.dart' as http;

import '../constants.dart';
import '../models/userDetails_model.dart';
import '../service_import.dart';
import 'api/endpoints.dart';

class UserService extends ServiceImport {
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
