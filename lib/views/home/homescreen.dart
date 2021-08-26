import 'package:BusTracking_App/core/routes/router_path.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(kSigninScreen);
          },
          child: Text("SignIn"),
        ),
      )),
    );
  }
}
