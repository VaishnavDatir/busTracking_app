import 'package:BusTracking_App/theme/colors.dart';
import 'package:BusTracking_App/theme/dimensions.dart';
import 'package:BusTracking_App/views/components/customTextInputField.dart';
import 'package:BusTracking_App/views/stop_list/stopList_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class StopsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StopListViewModel>.reactive(
      viewModelBuilder: () => StopListViewModel(),
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
          body: Container(
            child: Column(
              children: [
                SizedBox(
                  height: kMediumSpace,
                ),
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
                  child: model.stopsDataList.length == 0
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
                              Text("Can't find any stops.")
                            ],
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: () => model.refreshStopList(),
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: model.stopsDataList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                child: ListTile(
                                  leading: Container(
                                      height: double.infinity,
                                      padding: EdgeInsets.all(kMediumSpace),
                                      decoration: BoxDecoration(
                                          color: kBGCardBorder.withOpacity(0.1),
                                          shape: BoxShape.circle),
                                      child: Icon(
                                        Icons.location_city,
                                        size: kIconSize,
                                        color: kPrimaryColor,
                                      )),
                                  title: Text(model
                                      .stopsDataList[index].stopName
                                      .toString()),
                                  subtitle: Text(model
                                      .stopsDataList[index].stopCity
                                      .toString()),
                                ),
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
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
