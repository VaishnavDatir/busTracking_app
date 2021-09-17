class Endpoints {
  Endpoints._();
  //To access the loaclhost
  // static const String herokuServerUrl = "10.0.2.2:<port on which server is running>";
  //For real device user=:<ipAddress>:<port on which server is running>

  static const String localhost = "10.0.2.2:8080";
  static const String herokuServerHttp = "http://10.0.2.2:8080";

  static const String herokuServer = "bus-tracking-app.herokuapp.com";
  static const String herokuServerHttps =
      "https://bus-tracking-app.herokuapp.com";

  static const String getUserData = "/auth/getUserData";

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
