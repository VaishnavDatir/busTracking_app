import 'package:BusTracking_App/theme/colors.dart';
import 'package:BusTracking_App/theme/dimensions.dart';
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
              child: Text(
                "Sign in",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kWhite,
                  fontSize: kLargeSpace * 2,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          Column(
            children: [
              TabBar(
                controller: _tabController,
                labelPadding: EdgeInsets.fromLTRB(0, 2, 0, 2),
                unselectedLabelColor: kTextLightGrey,
                indicatorColor: kPrimaryColor,
                indicatorWeight: 3,
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kTextGrey,
                ),
                unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
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
                  children: [
                    Container(
                      child: Column(
                        children: [
                          TextField(),
                          TextField(),
                        ],
                      ),
                    ),
                    Container()
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
