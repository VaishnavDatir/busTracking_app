import 'package:BusTracking_App/core/constants.dart';
import 'package:BusTracking_App/theme/colors.dart';
import 'package:BusTracking_App/theme/dimensions.dart';
import 'package:BusTracking_App/theme/themes.dart';
import 'package:flutter/material.dart';

class AboutView extends StatelessWidget {
  const AboutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Constants.appName,
          style: appTheme.primaryTextTheme.headline6!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Divider(),
          SizedBox(
            height: kXXLSpace,
          ),
          Icon(
            Icons.directions_bus,
            color: kPrimaryColor,
            size: kLargeIconSize,
          ),
          SizedBox(
            height: kXXLSpace,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: kLargeSpace),
            child: Text(
              "This application provides the users with the current location of the bus according to the source and destination.",
              style: appTheme.textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: kXXLSpace,
          ),
          Text(
            "A project by,",
            style: appTheme.textTheme.bodyText1,
          ),
          SizedBox(
            height: kMediumSpace,
          ),
          Text(
            "Vaishnav Datir",
            style: appTheme.textTheme.bodyText2!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            "Sahil Suvarna",
            style: appTheme.textTheme.bodyText2!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            "Manoj Suvarna",
            style: appTheme.textTheme.bodyText2!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Text(
            "Made in India 🇮🇳",
            style: appTheme.textTheme.bodyText2,
            // textAlign: TextAlign.center,
          ),
          SizedBox(
            height: kXXLSpace,
          ),
        ],
      ),
    );
  }
}
