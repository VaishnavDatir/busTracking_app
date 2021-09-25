import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../theme/colors.dart';
import '../../../theme/dimensions.dart';
import '../../../theme/themes.dart';
import 'driverHome_viewmodel.dart';

class DriverHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DriverHomeViewModel>.reactive(
      viewModelBuilder: () => DriverHomeViewModel(),
      onModelReady: (model) => model.initializeScreen(),
      builder: (context, model, child) {
        return model.isBusy
            ? Material(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : WillPopScope(
                onWillPop: () => model.handleExit(),
                child: Scaffold(
                  appBar: AppBar(),
                  drawer: buildDrawer(model),
                  body: Stack(
                    children: [
                      model.isDriverOnBus
                          ? Card(
                              child: SwitchListTile(
                                value: model.isDriverOnBus,
                                onChanged: (value) =>
                                    model.changeIsDriverOnBus(),
                                title: Text(
                                  "On Duty",
                                  style: TextStyle(color: kBlack),
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              );
      },
    );
  }

  Drawer buildDrawer(DriverHomeViewModel model) {
    return Drawer(
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
                      "${model.userDetails.data.name.toString().substring(0, 1)}",
                      style: appTheme.textTheme.headline5
                          .copyWith(color: kDarkPrimaryColor),
                    ),
                  ),
                ),
                title: Text(
                  "${model.userDetails.data.name.toString()}",
                  style: TextStyle(color: kWhite, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "${model.userDetails.data.type}",
                  style: TextStyle(color: kTextOffWhite),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text("Stop List"),
              onTap: () => model.showStopList(),
            ),
            ListTile(
              leading: Icon(Icons.list_alt_rounded),
              title: Text("Bus List"),
              onTap: () => model.showBusList(),
            ),
            ListTile(
              leading: Icon(Icons.directions_bus_sharp),
              title: Text("Go on-duty"),
              onTap: () => model.handleGoOnDuty(),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () => model.handleLogout(),
            )
          ],
        ),
      ),
    );
  }
}
