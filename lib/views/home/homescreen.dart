import 'package:BusTracking_App/theme/colors.dart';
import 'package:BusTracking_App/theme/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../core/constants.dart';
import '../../theme/themes.dart';
import 'home_viewmodel.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.nonReactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) => model.initializeScreen(),
      builder: (context, model, child) {
        return Scaffold(
          body: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.directions_bus,
                    color: kPrimaryColor,
                    size: kLargeIconSize,
                  ),
                  SizedBox(
                    height: kMediumSpace,
                  ),
                  Text(
                    Constants.appName,
                    style: appTheme.primaryTextTheme.headline5,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
