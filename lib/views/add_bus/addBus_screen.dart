import 'package:BusTracking_App/theme/colors.dart';
import 'package:BusTracking_App/theme/themes.dart';
import 'package:BusTracking_App/views/components/customTextInputField.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../theme/dimensions.dart';
import 'addBus_viewmodel.dart';

class CreateBusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateBusViewModel>.reactive(
      viewModelBuilder: () => CreateBusViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          key: model.scaffoldKey,
          appBar: AppBar(
            title: Text("Create stop"),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: kMediumSpace),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: kMediumSpace,
                ),
                CustomTextInputField(
                  controller: null,
                  hintText: "",
                  labelText: "Bus Number",
                ),
                SizedBox(
                  height: kMediumSpace,
                ),
                CustomTextInputField(
                  controller: null,
                  hintText: "",
                  labelText: "Bus Provider",
                ),
                Text(
                  "Example: NMMT, BEST, KDMT, etc",
                  style: appTheme.textTheme.overline.copyWith(
                    color: kTextGrey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(
                  height: kMediumSpace,
                ),
                CustomTextInputField(
                  controller: null,
                  hintText: "",
                  labelText: "Bus Type",
                ),
                Text(
                  "Example: AC, Non-AC, Electric, etc",
                  style: appTheme.textTheme.overline.copyWith(
                    color: kTextGrey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(
                  height: kMediumSpace,
                ),
                Divider(
                  height: kDividerSize,
                ),
                SizedBox(
                  height: kMediumSpace,
                ),
                Text(
                  "Bus Timings",
                  style: appTheme.textTheme.headline6
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Wrap(
                  spacing: kMediumSpace,
                  runSpacing: kZeroSpace,
                  children: [
                    ...List.generate(
                        model.busTimingList.length,
                        (index) => InputChip(
                            label: Text(model.busTimingList[index]),
                            onDeleted: () => model.removeTiming(index))),
                    RaisedButton.icon(
                        onPressed: () => model.addTiming(context),
                        icon: Icon(
                          Icons.add_circle_outline,
                          color: kWhite,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(kRadius)),
                        label:
                            Text("Add time", style: appTheme.textTheme.button))
                  ],
                ),
                SizedBox(
                  height: kMediumSpace,
                ),
                Divider(
                  height: kDividerSize,
                ),
                SizedBox(
                  height: kMediumSpace,
                ),
                Text(
                  "Bus Route",
                  style: appTheme.textTheme.headline6
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: model.busRouteList.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: UniqueKey(),
                      background: Container(
                        color: kErrorRed,
                        padding: EdgeInsets.symmetric(horizontal: kLargeSpace),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Remove",
                              style: TextStyle(
                                  color: kWhite, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Remove",
                              style: TextStyle(
                                  color: kWhite, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      onDismissed: (direction) {
                        model.removeStop(index);
                      },
                      child: Card(
                        child: ListTile(
                          leading: Container(
                            padding: EdgeInsets.all(kMediumSpace + kSmallSpace),
                            child: Text(
                              (index + 1).toString(),
                              style: TextStyle(color: kWhite),
                            ),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: kPrimaryColor),
                          ),
                          title: Text(model.busRouteList[index].stopName),
                        ),
                      ),
                    );
                  },
                ),
                RaisedButton.icon(
                    onPressed: () => model.addRoute(),
                    icon: Icon(
                      Icons.add_circle_outline,
                      color: kWhite,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(kRadius)),
                    label: Text("Add Stop", style: appTheme.textTheme.button))
              ],
            ),
          ),
        );
      },
    );
  }
}
