class Endpoints {
  Endpoints._();
  //To access the loaclhost
  // static const String herokuServerUrl = "10.0.2.2:<port on which server is running>";
  //For real device user=:<ipAddress>:<port on which server is running>

  static const bool isDev = true;

  static const String localhost = "192.168.3.176:8080";
  static const String localhostHttp = "http://$localhost";

  static const String herokuServer = "bus-tracking-app.herokuapp.com";
  static const String herokuServerHttps =
      "https://bus-tracking-app.herokuapp.com";

  // <------------------------------ User ------------------------------------>
  /// To get User Details (GET Request)
  static const String getUserData = "/auth/getUserData";

  /// To update user location (POST Request)
  static const String updateUserLocation = "/user/updateLocation";

  /// To update user isActive status (Post Request)
  static const String updateUserIsActive = "/user/updateIsActive";

  /// To assign driver on bus (Post Request)
  static const String setDriverOnBus = "/user/setDriverOnBus";

  /// To remove driver from bus (GET Request)
  static const String removeDriverOnBus = "/user/removeDriverOnBus";

  // <------------------------------ Auth ------------------------------------>
  /// To Sign up user (POST Request)
  static const String signUpPost = "/auth/signupuser";

  /// To Sign in user (POST Request)
  static const String signInPost = "/auth/signin";

  // <------------------------------- Bus ------------------------------------>
  ///To Get list of all buses (GET Request)
  static const String getAllBuses = "/bus/allbuses";

  ///To create bus (POST Request)
  static const String createBusPost = "/bus/createbusroute";

  ///Search bus according to source and destination
  static const String searchBusBySourceAndDestination =
      "/bus/searchBusFromSourceToDestination";

  ///To Get bus details (GET Request)
  static const String getBusDetail = "/bus/busDetail";

  // <------------------------------ Stops ----------------------------------->
  ///To Get list of all Stops (GET Request)
  static const String getAllStops = "/bus/allstops";

  ///To create stop (POST Request)
  static const String createStopPost = "/bus/createstop";
}
