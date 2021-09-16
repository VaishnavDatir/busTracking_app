import 'package:BusTracking_App/theme/colors.dart';
import 'package:BusTracking_App/theme/dimensions.dart';
import 'package:BusTracking_App/views/bus_list/busList_viewmodel.dart';
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
                  child: ListView.separated(
                    itemCount: model.busModelData.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () =>
                            model.handleOnBusTap(model.busModelData[index].id),
                        leading: Container(
                            height: double.infinity,
                            padding: EdgeInsets.all(kMediumSpace),
                            decoration: BoxDecoration(
                                color: kBGCardBorder.withOpacity(0.1),
                                shape: BoxShape.circle),
                            child: Icon(
                              Icons.directions_bus,
                              size: kIconSize,
                              color: kPrimaryColor,
                            )),
                        title: Text(model.busModelData[index].busNumber),
                        subtitle: Text(model.busModelData[index].busType),
                        trailing: Chip(
                            label: Text(model.busModelData[index].busProvider)),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        Divider(color: kPrimaryColor),
                  ),
                )
              : Container(),
        );
      },
    );
  }
}
