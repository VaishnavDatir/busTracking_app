import 'dart:async';
import 'dart:convert';

// import 'package:BusTracking_App/core/services/api/endpoints.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'service_import.dart';
import 'services/api/endpoints.dart';

class StreamSocket extends ServiceImport {
  // final _socketResponse = StreamController();
  IO.Socket socket = IO.io(
      Endpoints.isDev ? Endpoints.localhostHttp : Endpoints.herokuServerHttps,
      <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });

  StreamController _socketResponse = StreamController.broadcast();

  void Function(List<dynamic>?) get addResponse => _socketResponse.sink.add;
  Stream get getResponse => _socketResponse.stream;

  void get streamClose async => await _socketResponse.close();

  String? myClientId;

  socketConnect() async {
    try {
      socket.connect().onConnectError((data) {
        print("C-Error: " + data.toString());
        socket.destroy();
      });

      socket.on('connect', (_) {
        print('## Connected to Socket: ${socket.id}');
        myClientId = socket.id.toString();
      });
      socket.on('disconnect', (_) => print('## Disconnected from Socket!'));
      socket.on('location', handleLocationListen);

      socket.onError((data) => print(data));
    } catch (e) {
      print("## Final error: " + e.toString());
    }
  }

  handleLocationListen(data) async {
    // print("called handleLocationListen");
    addResponse(data);
    // print(data);
  }

  // Send Location to Server
  sendLocation(Map<String, dynamic> data) {
    var locationData = json.encode({
      "bus": data["bus"],
      "latitude": data["latitude"],
      "longitude": data["longitude"],
    });
    socket.emit("location", locationData);
  }

  removeDriver() {
    socket.emit("userOfDuty", socket.id);
  }

  socketDisconnect() {
    print("## Disconnecting From socket...");
    socket.close();
  }

  socketEnd() {
    print("## Ending socket...");
    socket.destroy();
  }

  checkSocketStatus(_) {
    bool isConnected = socket.connected;
    return isConnected;
  }
}
