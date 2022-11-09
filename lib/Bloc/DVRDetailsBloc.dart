// ignore_for_file: constant_identifier_names, file_names

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:live_streaming/Model/Admin/DVR/DVR.dart';
import 'package:live_streaming/Model/Admin/ip.dart';
import 'package:live_streaming/Store/store.dart';
import 'package:velocity_x/velocity_x.dart';

enum DVRDetailsAction { Fetch }

class DVRDetailsBloc {
  static List<DVR> lst = [];
  DVR? c;
  int? index;
  final _stateDVRDetailsController = StreamController<List<DVR>>.broadcast();
  StreamSink<List<DVR>> get _sinkDVRDetails => _stateDVRDetailsController.sink;
  Stream<List<DVR>> get streamDVRDetails => _stateDVRDetailsController.stream;

  final _eventDVRDetailsController =
      StreamController<DVRDetailsAction>.broadcast();
  StreamSink<DVRDetailsAction> get eventsinkDVRDetails =>
      _eventDVRDetailsController.sink;
  Stream<DVRDetailsAction> get _eventstreamDVRDetails =>
      _eventDVRDetailsController.stream;

  DVRDetailsBloc() {
    _eventstreamDVRDetails.listen((event) async {
      if (event == DVRDetailsAction.Fetch) {
        try {
          var data = await getData();
          _sinkDVRDetails.add(data);
        } catch (e) {
          _sinkDVRDetails.addError("Something Went Wrong..");
        }
      }
    });
  }

  Future<List<DVR>> getData() async {
    lst = [];
    (VxState.store as MyStore).lstDVR = [];
    try {
      await http
          .get(Uri.parse('${NetworkIP.base_url}api/dvr-details'))
          .then((response) {
        if (response.statusCode == 200) {
          lst = [];
          var data = json.decode(response.body);
          for (int i = 0; i < data['ip'].length; i++) {
            DVR c = DVR(
                ip: data['ip'][i],
                channel: data['channel'][i],
                host: data['host'][i],
                password: data['password'][i]);

            lst.add(c);
          }
        }
      });
      (VxState.store as MyStore).lstDVR = lst;
      return lst;
    } catch (e) {
      return lst;
    }
  }
}
