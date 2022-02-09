import '../../app/app.router.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../core/constants.dart';
import '../../core/service_import.dart';
import '../components/setup_dialog_ui.dart';

class SignInViewModel extends BaseViewModel with ServiceImport {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _emailTC = TextEditingController();
  TextEditingController get emailTC => this._emailTC;
  FocusNode _emailFN = FocusNode();
  FocusNode get emailFN => this._emailFN;

  TextEditingController _passwordTC = TextEditingController();
  TextEditingController get passwordTC => this._passwordTC;
  FocusNode _passwordFN = FocusNode();
  FocusNode get passwordFN => this._passwordFN;

  String? _emailId, _password;

  bool _isObscureText = true;
  bool get isObscureText => this._isObscureText;

  String _screenText = Constants.appName;
  String get screenText => this._screenText;

  changeObsecureValue() {
    _isObscureText = !_isObscureText;
    notifyListeners();
  }

  initializeScreen() async {
    _emailFN.addListener(() {
      if (_emailFN.hasFocus || _passwordFN.hasFocus) {
        _screenText = "Sign in";
      } else {
        _screenText = Constants.appName;
      }
    });
    _passwordFN.addListener(() {
      if (_emailFN.hasFocus || _passwordFN.hasFocus) {
        _screenText = "Sign in";
      } else {
        _screenText = Constants.appName;
      }
    });
    notifyListeners();
  }

  handleSignInTap(BuildContext context) async {
    if (_emailTC.text.trim().length < 4 || !_emailTC.text.contains("@")) {
      await dialogService.showDialog(
          description: "Please enter correct email address");

      FocusScope.of(context).requestFocus(_emailFN);
    } else if (_passwordTC.text.length < 4) {
      await dialogService.showDialog(
          description: "Password cannot be less than 4 characters");
      FocusScope.of(context).requestFocus(_passwordFN);
    } else {
      dialogService.showCustomDialog(variant: DialogType.loading);

      _emailId = _emailTC.text.toString().trim();
      _password = _passwordTC.text.toString().trim();

      Map<String, dynamic> signInResponse =
          await (authService.signInUser(_emailId, _password));

      if (signInResponse["success"]) {
        await sharedPrefsService.write(
            Constants.sharedPrefsToken, signInResponse["token"]);

        await sharedPrefsService.write(
            Constants.sharedPrefsUserId, signInResponse["userId"]);

        bool _isDriver =
            signInResponse["type"].toString().toLowerCase().contains("driver");
        await sharedPrefsService.write(
            Constants.sharedPrefsUserType, _isDriver);

        await sharedPrefsService.write(Constants.sharedPrefsIsSignedIn, true);

        streamSocket.socketConnect();

        await authService.getUserToken();
        await userService.getUserData();
        await busService.getAllStops();
        await busService.getAllBusList();

        if (_isDriver) {
          // navigationService!.popEverythingAndNavigateTo(kDriverHomeScreen);
          navigationService.clearStackAndShow(Routes.driverHomeScreen);
        } else {
          // navigationService!.popEverythingAndNavigateTo(kPassengerHomeScreen);
          navigationService.clearStackAndShow(Routes.passengerHomeScreen);
        }
      } else {
        await dialogService.showDialog(
            title: "Oops!", description: signInResponse["message"]);
      }

      navigationService.back();
    }
  }

  gotoSignUpScreen() {
    FocusScope.of(scaffoldKey.currentContext!).unfocus();
    // navigationService.navigateTo(kSignupScreen);
    navigationService.navigateTo(Routes.signUpScreen);
  }
}
