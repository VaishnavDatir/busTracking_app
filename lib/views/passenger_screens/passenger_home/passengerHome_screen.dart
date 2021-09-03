import 'package:BusTracking_App/theme/colors.dart';
import 'package:BusTracking_App/theme/dimensions.dart';
import 'package:BusTracking_App/theme/themes.dart';
import 'package:BusTracking_App/views/passenger_screens/passenger_home/passengerHome_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class PassengerHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PassengerViewModel>.nonReactive(
      viewModelBuilder: () => PassengerViewModel(),
      onModelReady: (model) => model.initializeScreen(),
      builder: (context, model, child) {
        return model.isBusy
            ? Material(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Scaffold(
                appBar: AppBar(
                  title: Text("Hello"),
                ),
                drawer: Drawer(
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: kXXXLSpace * 3,
                          color: kPrimaryColor,
                          alignment: Alignment.bottomCenter,
                          child: ListTile(
                            leading: Container(
                              width: kXXLSpace + kLargeSpace,
                              height: kXXLSpace + kLargeSpace,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: kWhite,
                              ),
                              child: Center(
                                child: Text(
                                  "V",
                                  style: appTheme.textTheme.headline2,
                                ),
                              ),
                            ),
                            title: Text("Vaishnav Datir"),
                            subtitle: Text("Passenger"),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}
