import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

import '../../core/constants.dart';
import '../../core/routes/router_path.dart';
import '../../core/service_import.dart';

class SignUpViewModel extends BaseViewModel with ServiceImport {
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController get nameTextController => this._nameTextController;
  FocusNode _nameTextFN = FocusNode();
  FocusNode get nameTextFN => this._nameTextFN;

  TextEditingController _emailTC = TextEditingController();
  TextEditingController get emailTC => this._emailTC;
  FocusNode _emailFN = FocusNode();
  FocusNode get emailFN => this._emailFN;

  TextEditingController _passwordTC = TextEditingController();
  TextEditingController get passwordTC => this._passwordTC;
  FocusNode _passwordFN = FocusNode();
  FocusNode get passwordFN => this._passwordFN;

  String _name, _emailId, _password;

  bool _isObscureText = true;
  bool get isObscureText => this._isObscureText;

  bool _isDriver = false;
  bool get isDriver => this._isDriver;

  changeObsecureValue() {
    _isObscureText = !_isObscureText;
    notifyListeners();
  }

  handleSignUpTap(BuildContext context) async {
    if (_nameTextController.text.trim().length < 4) {
      await dialogService.showDialog(description: "Please enter correct name");

      FocusScope.of(context).requestFocus(_nameTextFN);
    } else if (_emailTC.text.trim().length < 4 ||
        !_emailTC.text.contains("@")) {
      await dialogService.showDialog(
          description: "Please enter correct email address");

      FocusScope.of(context).requestFocus(_emailFN);
    } else if (_passwordTC.text.length < 4) {
      await dialogService.showDialog(
          description: "Password cannot be less than 4 characters");
      FocusScope.of(context).requestFocus(_passwordFN);
    } else {
      dialogService.showLoadingDialog();
      _name = _nameTextController.text.toString().trim();
      _emailId = _emailTC.text.toString().trim();
      _password = _passwordTC.text.toString().trim();
      String _type = _isDriver ? "Driver" : "Passenger";

      Map<String, dynamic> signUpResponse =
          await authService.signUpUser(_name, _emailId, _password, _type);

      if (signUpResponse["success"]) {
        Map<String, dynamic> signInResponse =
            await authService.signInUser(_emailId, _password);

        if (signInResponse["success"]) {
          await sharedPrefsService.write(
              Constants.sharedPrefsToken, signInResponse["token"]);

          await sharedPrefsService.write(
              Constants.sharedPrefsUserId, signInResponse["userId"]);

          bool _isDriver = signInResponse["type"]
              .toString()
              .toLowerCase()
              .contains("driver");
          await sharedPrefsService.write(
              Constants.sharedPrefsUserType, _isDriver);

          await sharedPrefsService.write(Constants.sharedPrefsIsSignedIn, true);

          if (_isDriver) {
            navigationService.popEverythingAndNavigateTo(kDriverHomeScreen);
          } else {
            navigationService.popEverythingAndNavigateTo(kPassengerHomeScreen);
          }
        } else {
          await dialogService.showDialog(
              title: "Oops!", description: signInResponse["message"]);
        }
      } else {
        await dialogService.showDialog(
            title: "Oops!",
            description: signUpResponse["message"] +
                "\n" +
                (signUpResponse["data"] == null
                    ? ""
                    : signUpResponse["data"] ?? ""));
      }
      dialogService.dialogDismiss();
    }
  }

  changeSignUpType() {
    _isDriver = !_isDriver;
    notifyListeners();
  }
}
