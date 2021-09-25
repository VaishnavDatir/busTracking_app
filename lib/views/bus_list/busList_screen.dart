import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../theme/colors.dart';
import '../../theme/dimensions.dart';
import '../../theme/themes.dart';
import '../components/customTextInputField.dart';
import 'busList_viewmodel.dart';

class BusListScreen extends StatelessWidget {
  final Map<String, dynamic> screenData;
  BusListScreen(this.screenData);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BusListViewModel>.reactive(
      viewModelBuilder: () => BusListViewModel(),
      onModelReady: (model) => model.initializeScreen(screenData),
      builder: (context, model, child) {
        return model.isBusy
            ? Material(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Scaffold(
                appBar: AppBar(
                  title: Text(
                    model.driverGoingOnDuty ? "Select bus" : "Bus list",
                    style: TextStyle(
                        fontSize: kTextTitleSize, fontWeight: FontWeight.bold),
                  ),
                ),
                body: model.busModel.success
                    ? RefreshIndicator(
                        onRefresh: () => model.doRefresh(),
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: kMediumSpace,
                                      vertical: kMediumSpace),
                                  child: CustomTextInputField(
                                    controller: model.searchTextController,
                                    hintText: "Search",
                                    prefixIcon: Icon(Icons.search),
                                    onChanged: (value) => model
                                        .filterSearchResults(value.toString()),
                                  )),
                              Expanded(
                                child: model.busModelData.length == 0
                                    ? Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "¯" + r"\" + "_(ツ)_/¯",
                                              style: TextStyle(
                                                  fontSize: kXXLSpace,
                                                  color: kDarkPrimaryColor),
                                            ),
                                            SizedBox(height: kLargeSpace),
                                            Text("Can't find any bus")
                                          ],
                                        ),
                                      )
                                    : ListView.separated(
                                        shrinkWrap: true,
                                        itemCount: model.busModelData.length,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            onTap: () => model.handleOnBusTap(
                                                model.busModelData[index].id),
                                            leading: Container(
                                                height: double.infinity,
                                                padding: EdgeInsets.all(
                                                    kMediumSpace),
                                                decoration: BoxDecoration(
                                                    color: kBGCardBorder
                                                        .withOpacity(0.1),
                                                    shape: BoxShape.circle),
                                                child: Icon(
                                                  Icons.directions_bus,
                                                  size: kIconSize,
                                                  color: kPrimaryColor,
                                                )),
                                            title: Text(model
                                                .busModelData[index].busNumber),
                                            subtitle: Text(model
                                                .busModelData[index].busType),
                                            trailing: Chip(
                                                label: Text(model
                                                    .busModelData[index]
                                                    .busProvider)),
                                          );
                                        },
                                        separatorBuilder: (context, index) =>
                                            Divider(color: kPrimaryColor),
                                      ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(),
                floatingActionButton: model.driverGoingOnDuty
                    ? null
                    : FloatingActionButton.extended(
                        onPressed: () => model.addBuss(),
                        icon: Icon(
                          Icons.add,
                          color: kWhite,
                        ),
                        label: Text("Create Bus",
                            style: appTheme.textTheme.button
                                .copyWith(color: kWhite)),
                      ),
              );
      },
    );
  }
}
