import 'package:BusTracking_App/theme/colors.dart';
import 'package:BusTracking_App/theme/dimensions.dart';
import 'package:BusTracking_App/views/bus_list/busList_viewmodel.dart';
import 'package:BusTracking_App/views/components/customTextInputField.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class BusListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BusListViewModel>.reactive(
      viewModelBuilder: () => BusListViewModel(),
      onModelReady: (model) => model.initializeScreen(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Bus List",
              style: TextStyle(
                  fontSize: kTextTitleSize, fontWeight: FontWeight.bold),
            ),
          ),
          body: model.busModel.success
              ? Container(
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: kMediumSpace, vertical: kMediumSpace),
                          child: CustomTextInputField(
                            controller: model.searchTextController,
                            hintText: "Search",
                            prefixIcon: Icon(Icons.search),
                            addContentPadding: true,
                            onChanged: (value) =>
                                model.filterSearchResults(value.toString()),
                          )),
                      Expanded(
                        child: model.busModelData.length == 0
                            ? Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                        padding: EdgeInsets.all(kMediumSpace),
                                        decoration: BoxDecoration(
                                            color:
                                                kBGCardBorder.withOpacity(0.1),
                                            shape: BoxShape.circle),
                                        child: Icon(
                                          Icons.directions_bus,
                                          size: kIconSize,
                                          color: kPrimaryColor,
                                        )),
                                    title: Text(
                                        model.busModelData[index].busNumber),
                                    subtitle:
                                        Text(model.busModelData[index].busType),
                                    trailing: Chip(
                                        label: Text(model
                                            .busModelData[index].busProvider)),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    Divider(color: kPrimaryColor),
                              ),
                      ),
                    ],
                  ),
                )
              : Container(),
        );
      },
    );
  }
}
