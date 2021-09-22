import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../theme/dimensions.dart';
import '../../theme/themes.dart';
import '../components/customTextInputField.dart';
import 'add_stop_viewmodel.dart';

class AddStopScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddStopViewModel>.reactive(
      viewModelBuilder: () => AddStopViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Create stop"),
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
