import 'package:BusTracking_App/theme/colors.dart';
import 'package:BusTracking_App/theme/dimensions.dart';
import 'package:BusTracking_App/theme/themes.dart';
import 'package:flutter/material.dart';

class SigninScreen extends StatefulWidget {
  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen>
    with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: kXXXLSpace * 4,
            color: kPrimaryColor,
            child: Center(
              child: Text("Sign in",
                  textAlign: TextAlign.center,
                  style: appTheme.textTheme.bodyText2.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: kLargeSpace * 2,
                      color: kWhite)),
            ),
          ),
          TabBar(
            controller: _tabController,
            labelPadding: EdgeInsets.fromLTRB(0, 2, 0, 2),
            unselectedLabelColor: kTextLightGrey,
            indicatorColor: kPrimaryColor,
            indicatorWeight: 3,
            labelStyle: appTheme.textTheme.bodyText2
                .copyWith(fontWeight: FontWeight.w600),
            // unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            tabs: [
              Tab(
                child: Text(
                  "Passenger",
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              Tab(
                child: Text(
                  "Driver",
                  style: TextStyle(fontSize: 18.0),
                  textAlign: TextAlign.center,
                ),
              )
            ],
            isScrollable: false,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [PassengerScreenLogin(), DriverScreenLogin()],
            ),
          ),
        ],
      ),
    );
  }
}

class DriverScreenLogin extends StatelessWidget {
  String email, password;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(kLargeSpace),
      child: Column(
        children: [
          SizedBox(
            height: kLargeSpace,
          ),
          Text(
            "Let's start the journey!",
            style: appTheme.primaryTextTheme.headline4.copyWith(
              color: kTextLightGrey,
            ),
          ),
          SizedBox(
            height: kLargeSpace * 1,
          ),
          TextField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              email = value;
            },
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.email_sharp,
                  color: kTextBlack,
                ),
                labelText: 'Email'),
          ),
          SizedBox(height: kXLSpace),
          TextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock,
                  color: kTextBlack,
                ),
                labelText: 'Password'),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: FlatButton(
              onPressed: () {},
              child: Text(
                "Forgot Password ? ",
                style: TextStyle(
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
          SizedBox(
            height: kMediumSpace,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: RaisedButton(
              onPressed: () {},
              child: Text("Sign in"),
            ),
          ),
        ],
      ),
    );
  }
}

class PassengerScreenLogin extends StatelessWidget {
  String email, password;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(kLargeSpace),
      child: Column(
        children: [
          SizedBox(
            height: kLargeSpace,
          ),
          Text("Get the latest details for your daily traveling",
              style: appTheme.primaryTextTheme.headline4
                  .copyWith(color: kTextLightGrey)),
          SizedBox(
            height: kLargeSpace * 1,
          ),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              email = value;
            },
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.email_sharp,
                  color: kTextBlack,
                ),
                labelText: 'Email'),
          ),
          SizedBox(
            height: kXLSpace,
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock,
                  color: kTextBlack,
                ),
                labelText: 'Password'),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: FlatButton(
              onPressed: () {},
              child: Text(
                "Forgot Password ? ",
                style: TextStyle(
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
          SizedBox(
            height: kMediumSpace,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: RaisedButton(
              onPressed: () {},
              child: Text("Sign in"),
            ),
          ),
        ],
      ),
    );
  }
}
