import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:stacked/stacked.dart';

import '../../../core/constants.dart';
import '../../../theme/colors.dart';
import '../../../theme/dimensions.dart';
import '../../../theme/themes.dart';
import '../../components/customMarkar.dart';
import 'driverHome_viewmodel.dart';

class DriverHomeScreen extends StatefulWidget {
  @override
  _DriverHomeScreenState createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen>
    with TickerProviderStateMixin {
  MapController? mapController;
  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DriverHomeViewModel>.reactive(
      viewModelBuilder: () => DriverHomeViewModel(),
      onModelReady: (model) => model.initializeScreen(mapController),
      builder: (context, model, child) {
        return AnimatedSwitcher(
          duration: Duration(seconds: Constants.animatedSwitcherDuration),
          child: model.isBusy
              ? Material(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : WillPopScope(
                  onWillPop: () => model.handleExit(),
                  child: Scaffold(
                      extendBodyBehindAppBar: true,
                      appBar: AppBar(),
                      drawer: DriverScreenDrawer(model),
                      body: Stack(
                        children: [
                          buildMap(model),
                          /* Container(
                          child: Center(
                            child: StreamBuilder(
                              stream: model.stream,
                              builder: (context, snapshot) {
                                return Container(
                                  child: Text(snapshot.toString()),
                                );
                              },
                            ),
                          ),
                        ), */
                          if (model.isDriverOnBus!)
                            buildOnDutyCard(context, model),
                        ],
                      ),
                      floatingActionButton: FloatingActionButton(
                        child: Icon(
                          Icons.my_location_rounded,
                          color: kWhite,
                          size: kIconSize,
                        ),
                        onPressed: () => model.fabClick(this),
                      )),
                ),
        );
      },
    );
  }

  Widget buildOnDutyCard(BuildContext context, DriverHomeViewModel model) {
    return Positioned(
      top: 70,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Card(
          child: SwitchListTile(
            value: model.isDriverOnBus!,
            onChanged: (value) => model.changeIsDriverOnBus(),
            title: Text(
              "On Duty",
              style: TextStyle(color: kBlack),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMap(DriverHomeViewModel model) {
    return StreamBuilder(
      stream: model.stream,
      builder: (context, snapshot) {
        List<Marker> markers = [];
        List streamData = snapshot.data == null ? [] : snapshot.data as List;
        if (streamData.isNotEmpty) {
          print(streamData.toString());
          streamData.forEach((element) {
            markers.add(Marker(
              height: 65,
              width: 95,
              point: LatLng(double.parse(element["data"]["latitude"]),
                  double.parse(element["data"]["longitude"])),
              builder: (context) {
                return Container(
                  decoration: ShapeDecoration(
                    color: element["client_id"].toString() ==
                            model.clientId.toString()
                        ? kPrimaryColor
                        : kWhite,
                    shape: CustomMarker(),
                    shadows: [
                      BoxShadow(
                          color: Colors.white24,
                          spreadRadius: -1,
                          blurRadius: 6,
                          offset: Offset(2, 3)),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: kLargeSpace),
                  child: Row(
                    children: [
                      Icon(
                        Icons.directions_bus,
                        color: element["client_id"].toString() ==
                                model.clientId.toString()
                            ? kWhite
                            : kPrimaryColor,
                      ),
                      Spacer(),
                      Text(
                        element["data"]["bus"]["busNumber"],
                        style: TextStyle(
                            fontSize: kLargeSpace,
                            color: element["client_id"].toString() ==
                                    model.clientId.toString()
                                ? kWhite
                                : kPrimaryColor,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                );
              },
            ));
          });
        }
        return FlutterMap(
          mapController: model.mapController,
          options: MapOptions(
            minZoom: 7,
            maxZoom: 18,
            zoom: 16,
          ),
          nonRotatedLayers: [
            TileLayerOptions(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayerOptions(markers: markers)
          ],
        );
      },
    );
  }
}

class DriverScreenDrawer extends StatelessWidget {
  final DriverHomeViewModel model;
  const DriverScreenDrawer(this.model);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: kXXXLSpace * 3,
              color: kPrimaryColor,
              alignment: Alignment.bottomCenter,
              child: ListTile(
                leading: Container(
                  width: kXXLSpace + kLargeSpace,
                  height: kXXLSpace + kLargeSpace,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: kWhite,
                  ),
                  child: Center(
                    child: Text(
                      "${model.userDetails!.data!.name.toString().substring(0, 1)}",
                      style: appTheme.textTheme.headline5!
                          .copyWith(color: kDarkPrimaryColor),
                    ),
                  ),
                ),
                title: Text(
                  "${model.userDetails!.data!.name.toString()}",
                  style: TextStyle(color: kWhite, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "${model.userDetails!.data!.type}",
                  style: TextStyle(color: kTextOffWhite),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text("Stop List"),
              onTap: () => model.showStopList(),
            ),
            ListTile(
              leading: Icon(Icons.list_alt_rounded),
              title: Text("Bus List"),
              onTap: () => model.showBusList(),
            ),
            ListTile(
              leading: Icon(Icons.directions_bus_sharp),
              title: Text("Go on-duty"),
              onTap: () => model.handleGoOnDuty(),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () => model.handleLogout(),
            ),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text("About"),
              onTap: () => model.handleAboutTap(),
            ),
            Spacer(),
            Text("Made in INDIA 🇮🇳"),
            SizedBox(height: kLargeSpace)
          ],
        ),
      ),
    );
  }
}
