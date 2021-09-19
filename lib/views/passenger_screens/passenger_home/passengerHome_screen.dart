import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/constants.dart';
import '../../../theme/colors.dart';
import '../../../theme/dimensions.dart';
import '../../../theme/themes.dart';
import '../../components/customTextInputField.dart';
import 'passengerHome_viewmodel.dart';

class PassengerHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PassengerViewModel>.reactive(
      viewModelBuilder: () => PassengerViewModel(),
      onModelReady: (model) => model.initializeScreen(),
      builder: (context, model, child) {
        return AnimatedSwitcher(
          duration: Duration(seconds: Constants.animatedSwitcherDuration),
          child: model.isBusy
              ? Material(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : WillPopScope(
                  onWillPop: () => model.handleExit(),
                  child: Scaffold(
                    key: model.scaffoldKey,
                    drawer: buildDrawer(model),
                    body: SafeArea(
                      child: Stack(
                        children: [
                          buildMap(), // YET TO IMPLEMENT
                          buildTopSearchBar(model),
                          buildBottomBusSheet(model),
                        ],
                      ),
                    ),
                    floatingActionButton: FloatingActionButton(
                      child: Icon(
                        Icons.location_pin,
                        color: kWhite,
                        size: kIconSize,
                      ),
                      onPressed: () => model.fabClick(),
                    ),
                  ),
                ),
        );
      },
    );
  }

  Container buildMap() {
    return Container(
      color: kBlack.withOpacity(0.5),
    );
  }

  Widget buildBottomBusSheet(PassengerViewModel model) {
    return Positioned.fill(
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: model.showBottomBusSheet
            ? DraggableScrollableSheet(
                initialChildSize: 0.3,
                maxChildSize: 0.5,
                minChildSize: 0.2,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return Container(
                    padding: EdgeInsets.only(top: kMediumSpace),
                    decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(kRadius / 5),
                          topRight: Radius.circular(kRadius / 5),
                        )),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: kMediumSpace),
                                  child: Text(
                                    "Available Buses",
                                    style: appTheme.textTheme.headline4,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: kMediumSpace),
                                  child: Text(model.sourceStop.stopName +
                                      " --- " +
                                      model.destinationStop.stopName),
                                ),
                              ],
                            ),
                            Spacer(),
                            IconButton(
                                tooltip: "Close",
                                icon: Icon(Icons.close_rounded),
                                onPressed: () => model.hideBottomBusSheet())
                          ],
                        ),
                        Divider(
                          color: kBGCard,
                        ),
                        Expanded(
                          child: model.busModelData.length == 0
                              ? SingleChildScrollView(
                                  controller: scrollController,
                                  child: Container(
                                    width: double.infinity,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(height: kXXLSpace),
                                        Text("(>_<)",
                                            style: TextStyle(
                                                fontSize: kXXLSpace,
                                                color: kDarkPrimaryColor)),
                                        SizedBox(height: kLargeSpace),
                                        Text(
                                            "Can't find any bus for this route.")
                                      ],
                                    ),
                                  ),
                                )
                              : ListView.separated(
                                  shrinkWrap: true,
                                  controller: scrollController,
                                  itemCount: model.busModelData.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ListTile(
                                      onTap: () => model.handleOnBusTap(
                                          model.busModelData[index].id),
                                      leading: Container(
                                          height: double.infinity,
                                          padding: EdgeInsets.all(kMediumSpace),
                                          decoration: BoxDecoration(
                                              color: kBGCardBorder
                                                  .withOpacity(0.1),
                                              shape: BoxShape.circle),
                                          child: Icon(
                                            Icons.directions_bus,
                                            size: kIconSize,
                                            color: kPrimaryColor,
                                          )),
                                      title: Text(
                                          model.busModelData[index].busNumber),
                                      subtitle: Text(
                                          model.busModelData[index].busType),
                                      trailing: Chip(
                                          label: Text(model.busModelData[index]
                                              .busProvider)),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return Divider(
                                      color: kBGCard,
                                      height: 4,
                                    );
                                  },
                                ),
                        ),
                      ],
                    ),
                  );
                },
              )
            : Container(),
      ),
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
      // margin: EdgeInsets.only(
      //   left: kMediumSpace,
      //   right: kMediumSpace,
      //   // top: kXXXLSpace + kSmallSpace,
      // ),
      child: Container(
        color: kWhite,
        child: Padding(
          padding: EdgeInsets.all(kMediumSpace),
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  tooltip: "Open navigation menu",
                  icon: Icon(Icons.menu),
                  splashRadius: kSmallIconSize,
                  color: kSecondaryPrimaryColor,
                  iconSize: kIconSize,
                  onPressed: () => model.openDrawer(),
                ),
                Expanded(
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
                                border:
                                    Border.all(color: kPrimaryColor, width: 2)),
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
                              iconSize: kIconSize,
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
                              onTap: () => model.handleSourceStopFieldTap(
                                  isDestination: true),
                            ),
                          ),
                          SizedBox(
                            width: kMediumSpace,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius:
                                    BorderRadius.circular(kRadius / 5)),
                            child: IconButton(
                                tooltip: "Search bus",
                                icon: Icon(Icons.search),
                                splashRadius: kXLSpace,
                                iconSize: kIconSize,
                                color: kWhite,
                                onPressed: () => model.serachBus()),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
