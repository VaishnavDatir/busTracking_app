import 'package:BusTracking_App/core/constants.dart';
import 'package:BusTracking_App/views/components/customTextInputField.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../theme/colors.dart';
import '../../../theme/dimensions.dart';
import '../../../theme/themes.dart';
import 'passengerHome_viewmodel.dart';
import 'dart:math';

class PassengerHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PassengerViewModel>.reactive(
      viewModelBuilder: () => PassengerViewModel(),
      onModelReady: (model) => model.initializeScreen(),
      builder: (context, model, child) {
        return AnimatedSwitcher(
          duration: Duration(seconds: 1),
          child: model.isBusy
              ? Material(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Scaffold(
                  key: model.scaffoldKey,
                  extendBodyBehindAppBar: true,
                  appBar: AppBar(
                    title: Text(
                      Constants.appName,
                      style: TextStyle(
                          color: kWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                    leading: IconButton(
                      tooltip: "Open navigation menu",
                      icon: Icon(Icons.menu),
                      color: kWhite,
                      iconSize: kIconSize,
                      onPressed: () => model.openDrawer(),
                    ),
                  ),
                  drawer: buildDrawer(model),
                  body: Stack(
                    children: [
                      Container(
                        color: kBlack.withOpacity(0.5),
                      ),
                      buildTopSearchBar(model),
                    ],
                  ),
                  floatingActionButton: FloatingActionButton(
                    child: Transform.rotate(
                        angle: pi * 0.5,
                        child: Icon(
                          Icons.multiple_stop,
                          color: kWhite,
                          size: kIconSize,
                        )),
                    onPressed: () => model.fabClick(),
                  ),
                ),
        );
      },
    );
  }

  Widget buildDrawer(PassengerViewModel model) {
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
                      style: appTheme.textTheme.headline2
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
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () => model.handleLogout(),
            )
          ],
        ),
      ),
    );
  }

  Widget buildTopSearchBar(PassengerViewModel model) {
    return Container(
      margin: EdgeInsets.only(
        left: kMediumSpace,
        right: kMediumSpace,
        top: kXXXLSpace + kSmallSpace,
      ),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(kMediumSpace),
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(
                      width: kLargeSpace,
                      height: kLargeSpace,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: kPrimaryColor, width: 2)),
                    ),
                    SizedBox(
                      width: kMediumSpace,
                    ),
                    Expanded(
                      child: CustomTextInputField(
                        controller: model.sourceTextController,
                        hintText: "At which stop you are?",
                        addContentPadding: true,
                        disabled: true,
                        onTap: () => model.handleSourceStopFieldTap(
                            isDestination: false),
                      ),
                    ),
                    SizedBox(
                      width: kMediumSpace,
                    ),
                    IconButton(
                        splashRadius: kXXLSpace,
                        tooltip: "Swap",
                        icon: Icon(Icons.swap_vert_outlined),
                        iconSize: kXXLSpace,
                        onPressed: () => model.handleSwap())
                  ],
                ),
                SizedBox(
                  height: kLargeSpace,
                ),
                Row(
                  children: [
                    Container(
                      width: kLargeSpace,
                      height: kLargeSpace,
                      decoration: BoxDecoration(
                          color: kPrimaryColor, shape: BoxShape.circle),
                    ),
                    SizedBox(
                      width: kMediumSpace,
                    ),
                    Expanded(
                      child: CustomTextInputField(
                        controller: model.destinationTextController,
                        hintText: "Where you want to go?",
                        addContentPadding: true,
                        disabled: true,
                        onTap: () =>
                            model.handleSourceStopFieldTap(isDestination: true),
                      ),
                    ),
                    SizedBox(
                      width: kMediumSpace,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(kRadius / 5)),
                      child: IconButton(
                          icon: Icon(Icons.search),
                          splashRadius: kXLSpace,
                          iconSize: kXXLSpace,
                          color: kWhite,
                          onPressed: () {}),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
