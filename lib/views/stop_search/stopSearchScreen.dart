import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../theme/colors.dart';
import '../../theme/dimensions.dart';
import '../components/customTextInputField.dart';
import 'stopSearch_viewmodel.dart';

class StopSearchScreen extends StatefulWidget {
  @override
  _StopSearchScreenState createState() => _StopSearchScreenState();
}

class _StopSearchScreenState extends State<StopSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StopSearchScreenViewModel>.reactive(
      viewModelBuilder: () => StopSearchScreenViewModel(),
      onModelReady: (model) => model.initializeScreen(),
      builder: (context, model, child) {
        return Scaffold(
          body: SafeArea(
            child: Container(
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
                    child: model.stopsDataList!.length == 0
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
                              itemCount: model.stopsDataList!.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  child: ListTile(
                                    onTap: () => model.handleStopTap(
                                        model.stopsDataList![index]),
                                    leading: Container(
                                        height: double.infinity,
                                        padding: EdgeInsets.all(kMediumSpace),
                                        decoration: BoxDecoration(
                                            color:
                                                kBGCardBorder.withOpacity(0.1),
                                            shape: BoxShape.circle),
                                        child: Icon(
                                          Icons.location_city,
                                          size: kIconSize,
                                          color: kPrimaryColor,
                                        )),
                                    title: Text(model
                                        .stopsDataList![index].stopName
                                        .toString()),
                                    subtitle: Text(model
                                        .stopsDataList![index].stopCity
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
          ),
        );
      },
    );
  }
}
