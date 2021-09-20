import 'package:BusTracking_App/theme/dimensions.dart';
import 'package:BusTracking_App/theme/themes.dart';
import 'package:BusTracking_App/views/add_stop/add_stop_viewmodel.dart';
import 'package:BusTracking_App/views/components/customTextInputField.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AddStopScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddStopViewModel>.reactive(
      viewModelBuilder: () => AddStopViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Add stop"),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: kMediumSpace),
            child: Column(
              children: [
                CustomTextInputField(
                    controller: model.stopNameController,
                    hintText: "Stop Name"),
                SizedBox(
                  height: kMediumSpace,
                ),
                CustomTextInputField(
                    controller: model.stopCityController,
                    hintText: "Stop City"),
                SizedBox(
                  height: kMediumSpace,
                ),
                RaisedButton(
                  onPressed: () => model.addStop(),
                  child: Text("Create", style: appTheme.textTheme.button),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
