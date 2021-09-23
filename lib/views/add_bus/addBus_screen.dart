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
            title: Text("Create new bus"),
          ),
          body: SingleChildScrollView(
            controller: model.scrollController,
            padding: EdgeInsets.symmetric(horizontal: kMediumSpace),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: kMediumSpace,
                ),
                buildTopTextFields(model),
                SizedBox(
                  height: kMediumSpace,
                ),
                Divider(
                  height: kDividerSize,
                ),
                SizedBox(
                  height: kMediumSpace,
                ),
                buildBusTiming(model, context),
                SizedBox(
                  height: kMediumSpace,
                ),
                Divider(
                  height: kDividerSize,
                ),
                SizedBox(
                  height: kMediumSpace,
                ),
                buildBusRoute(model),
                SizedBox(
                  height: kMediumSpace,
                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            icon: Icon(
              Icons.done,
              color: kWhite,
            ),
            onPressed: () => model.createBus(),
            label: Text("Submit",
                style: appTheme.textTheme.button.copyWith(color: kWhite)),
          ),
        );
      },
    );
  }

  Widget buildBusRoute(CreateBusViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                      style:
                          TextStyle(color: kWhite, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Remove",
                      style:
                          TextStyle(color: kWhite, fontWeight: FontWeight.bold),
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
                  subtitle: Text(model.busRouteList[index].stopCity),
                ),
              ),
            );
          },
        ),
        Container(
          // width: double.infinity,
          child: RaisedButton.icon(
              onPressed: () => model.addRoute(),
              color: kWhite,
              elevation: 0,
              icon: Icon(
                Icons.add_circle_outline,
                color: kPrimaryColor,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kRadius),
                  side: BorderSide(color: kPrimaryColor)),
              label: Text("Add Stop",
                  style: appTheme.textTheme.button
                      .copyWith(color: kPrimaryColor))),
        ),
      ],
    );
  }

  Widget buildBusTiming(CreateBusViewModel model, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Bus Timings",
          style: appTheme.textTheme.headline6
              .copyWith(fontWeight: FontWeight.bold),
        ),
        Wrap(
          spacing: kSmallSpace,
          children: [
            ...List.generate(
                model.busTimingList.length,
                (index) => Container(
                      child: InputChip(
                          label: Text(model.busTimingList[index]),
                          onDeleted: () => model.removeTiming(index)),
                    )),
            RaisedButton.icon(
                onPressed: () => model.addTiming(context),
                color: kWhite,
                elevation: 0,
                icon: Icon(
                  Icons.add_circle_outline,
                  color: kPrimaryColor,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(kRadius),
                    side: BorderSide(color: kPrimaryColor)),
                label: Text("Add Time",
                    style: appTheme.textTheme.button
                        .copyWith(color: kPrimaryColor))),
          ],
        ),
      ],
    );
  }

  Widget buildTopTextFields(CreateBusViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextInputField(
          controller: model.busNoTEC,
          focusNode: model.busNoFN,
          hintText: "",
          labelText: "Bus Number",
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.characters,
        ),
        SizedBox(
          height: kMediumSpace,
        ),
        CustomTextInputField(
          controller: model.busProviderTEC,
          focusNode: model.busProviderFN,
          hintText: "",
          labelText: "Bus Provider",
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.characters,
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
          controller: model.busTypeTEC,
          focusNode: model.busTypeFN,
          hintText: "",
          labelText: "Bus Type",
          textCapitalization: TextCapitalization.characters,
        ),
        Text(
          "Example: AC, Non-AC, Electric, etc",
          style: appTheme.textTheme.overline.copyWith(
            color: kTextGrey,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}
