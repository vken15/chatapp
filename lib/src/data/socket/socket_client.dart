import 'package:chatapp/src/core/constants/app_url.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketClient {
  io.Socket? socket;
  static SocketClient? _instance;
  //static String socketserverip = socketServerIp;
  SocketClient._internal() {
    // socket = io.io(AppEndpoint.PRODUCT_URL, <String, dynamic>{
    //   'transports': ['websocket'],
    //   'autoConnect': false,
    // });
    socket = io.io(
        AppEndpoint.PRODUCT_URL,
        io.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());
    socket!.connect();
  }

  static SocketClient get instance {
    // if (socketserverip != socketServerIp) {
    //   socketserverip = socketServerIp;
    //   _instance = SocketClient._internal();
    // } else {
    _instance ??= SocketClient._internal();
    //}
    return _instance!;
  }
}
