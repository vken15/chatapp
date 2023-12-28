import 'package:chatapp/src/core/constants/app_url.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketClient {
  io.Socket? socket;
  static SocketClient? _instance;
  SocketClient._internal() {
    socket = io.io(AppEndpoint.APP_URL, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      // 'extraHeaders': {HttpHeaders.authorizationHeader: accessToken}
    });
  }

  static SocketClient get instance {
    // const storage = FlutterSecureStorage();
    // var token = await storage.read(key: "UserToken");
    _instance ??= SocketClient._internal();
    return _instance!;
  }
}
