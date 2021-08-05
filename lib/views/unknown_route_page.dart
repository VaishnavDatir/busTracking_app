import 'package:flutter/material.dart';

class UnknownRoutePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Unknown Page'),
          automaticallyImplyLeading: true,
        ),
        body: Center(
          child: Text('Page not found'),
        ));
  }
}
