// ignore_for_file: non_constant_identifier_names

import 'package:web_socket_channel/io.dart';

class NetworkIP {
  static List<Stream> lst = [];
  static String base_url = 'http://192.168.43.192:8000/';

  static void Connect() {
    // final cam1 = IOWebSocketChannel.connect('ws://192.168.43.192:8000/1/ws');
    // final cam2 = IOWebSocketChannel.connect('ws://192.168.43.192:8000/2/ws');
    // final cam3 = IOWebSocketChannel.connect('ws://192.168.43.192:8000/3/ws');
    // final cam4 = IOWebSocketChannel.connect('ws://192.168.43.192:8000/4/ws');
    // final cam1broadcast = cam1.stream.asBroadcastStream();
    // final cam2broadcast = cam2.stream.asBroadcastStream();
    // final cam3broadcast = cam3.stream.asBroadcastStream();
    // final cam4broadcast = cam4.stream.asBroadcastStream();
    // lst = [cam1broadcast];
    // cam1broadcast.listen((data) => () {},
    //     onDone: () =>
    //         IOWebSocketChannel.connect('ws://192.168.43.192:8000/1/ws'));
    // cam2broadcast.listen((data) => () {},
    //     onDone: () =>
    //         IOWebSocketChannel.connect('ws://192.168.43.192:8000/2/ws'));
    // cam3broadcast.listen((data) => () {},
    //     onDone: () =>
    //         IOWebSocketChannel.connect('ws://192.168.43.192:8000/3/ws'));
    // cam4broadcast.listen((data) => () {},
    //     onDone: () =>
    //         IOWebSocketChannel.connect('ws://192.168.43.192:8000/4/ws'));
  }
}
