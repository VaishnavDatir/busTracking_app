import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../core/constants.dart';
import '../../theme/colors.dart';
import '../../theme/dimensions.dart';
import '../../theme/themes.dart';
import 'bus_detail_viewmodel.dart';

class BusDetailScreen extends StatelessWidget {
  final Map<String, dynamic>? screenData;
  BusDetailScreen(this.screenData);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BusDetailViewModel>.reactive(
      viewModelBuilder: () => BusDetailViewModel(),
      onModelReady: (model) => model.initializeScreen(screenData!),
      builder: (context, model, child) {
        return AnimatedSwitcher(
          duration: Duration(seconds: Constants.animatedSwitcherDuration),
          child: model.isBusy
              ? Material(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Scaffold(
                  appBar: AppBar(),
                  body: model.busDetailModel!.success!
                      ? Container(
                          child: Column(
                            children: [
                              buildTopBusBasicInfo(model),
                              Divider(
                                color: kBGCard,
                                height: 2,
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      buildBusTimings(model),
                                      Divider(
                                        color: kBGCard,
                                        height: 2,
                                      ),
                                      buildBusStops(model),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: kXXLSpace),
                              Text("(·.·)",
                                  style: TextStyle(
                                      fontSize: kXXLSpace,
                                      color: kDarkPrimaryColor)),
                              SizedBox(height: kLargeSpace),
                              Text("There was an error while getting data.")
                            ],
                          ),
                        ),
                  floatingActionButton: model.driverGoingOnDuty
                      ? FloatingActionButton.extended(
                          onPressed: () => model.setDriverForBus(),
                          icon: Icon(
                            Icons.done,
                            color: kWhite,
                          ),
                          label: Text("Select this bus",
                              style: appTheme.textTheme.button!
                                  .copyWith(color: kWhite)))
                      : FloatingActionButton(
                          tooltip: "Reverse route",
                          child: Icon(
                            Icons.import_export_rounded,
                            size: kIconSize,
                            color: kWhite,
                          ),
                          onPressed: () => model.fabReverseRoute(),
                        ),
                ),
        );
      },
    );
  }

  Widget buildBusStops(BusDetailViewModel model) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          horizontal: kMediumSpace, vertical: kMediumSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Bus Route",
            style: appTheme.textTheme.headline6!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Stepper(
            physics: NeverScrollableScrollPhysics(),
            controlsBuilder: (context, details) {
              return Container();
            },
            /* controlsBuilder: (context, {onStepCancel, onStepContinue}) {
              return Container();
            }, */
            onStepTapped: (value) {},
            steps: List.generate(
                model.busDetailData!.busStops!.length,
                (index) => Step(
                      isActive: true,
                      title: Text(
                        model.busDetailData!.busStops![index].stopName!,
                        style: TextStyle(
                            color: (model.busDetailData!.busStops![index].id ==
                                        model.sourceStopId) ||
                                    (model.busDetailData!.busStops![index].id ==
                                        model.destinationStopId)
                                ? kPrimaryColor
                                : kBlack),
                      ),
                      subtitle: Text(
                        model.busDetailData!.busStops![index].stopCity!,
                        style: TextStyle(
                            color: (model.busDetailData!.busStops![index].id ==
                                        model.sourceStopId) ||
                                    (model.busDetailData!.busStops![index].id ==
                                        model.destinationStopId)
                                ? kPrimaryColor
                                : kBlack),
                      ),
                      content: Container(),
                    )),
          ),
        ],
      ),
    );
  }

  Widget buildBusTimings(BusDetailViewModel model) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          horizontal: kMediumSpace, vertical: kMediumSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Bus Timings",
            style: appTheme.textTheme.headline6!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Wrap(
            spacing: kSmallSpace,
            runSpacing: kMediumSpace,
            children: List<Widget>.generate(
                model.busDetailData!.busTimings!.length,
                (index) => Chip(
                    label: Text(
                        model.busDetailData!.busTimings![index].toString()))),
          )
        ],
      ),
    );
  }

  Widget buildTopBusBasicInfo(BusDetailViewModel model) {
    return ListTile(
      leading: Container(
          height: double.infinity,
          padding: EdgeInsets.all(kMediumSpace),
          decoration: BoxDecoration(
              color: kBGCardBorder.withOpacity(0.1), shape: BoxShape.circle),
          child: Icon(
            Icons.directions_bus,
            size: kLargeIconSize,
            color: kPrimaryColor,
          )),
      title: Text(
        model.busDetailData!.busNumber!,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(model.busDetailData!.busType!),
      trailing: Chip(label: Text(model.busDetailData!.busProvider!)),
    );
  }
}
