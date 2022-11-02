// ignore_for_file: constant_identifier_names, file_names

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:live_streaming/Model/Admin/Camera/Camera.dart';
import 'package:live_streaming/Model/Admin/ip.dart';
import 'package:live_streaming/Store/store.dart';
import 'package:velocity_x/velocity_x.dart';

enum CameraDetailsAction { Fetch }

class CameraDetailsBloc {
  static List<Camera> lst = [];
  Camera? c;
  int? index;
  final _stateCameraDetailsController = StreamController<List<Camera>>();
  StreamSink<List<Camera>> get _sinkCameraDetails =>
      _stateCameraDetailsController.sink;
  Stream<List<Camera>> get streamCameraDetails =>
      _stateCameraDetailsController.stream;

  final _eventCameraDetailsController = StreamController<CameraDetailsAction>();
  StreamSink<CameraDetailsAction> get eventsinkCameraDetails =>
      _eventCameraDetailsController.sink;
  Stream<CameraDetailsAction> get _eventstreamCameraDetails =>
      _eventCameraDetailsController.stream;

  CameraDetailsBloc() {
    _eventstreamCameraDetails.listen((event) async {
      if (event == CameraDetailsAction.Fetch) {
        try {
          var data = await getData();
          _sinkCameraDetails.add(data);
        } catch (e) {
          _sinkCameraDetails.addError("Something Went Wrong..");
        }
      }
    });
  }

  Future<List<Camera>> getData() async {
    lst = [];
    (VxState.store as MyStore).lstcamera = [];
    try {
      await http
          .get(Uri.parse('${NetworkIP.base_url}api/camera-details'))
          .then((response) {
        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          for (int i = 0; i < data['room'].length; i++) {
            Camera c = Camera(
                ip: data['cameraip'][i],
                lt: data['room'][i],
                no: data['camerano'][i]);
            lst.add(c);
          }
        }
      });
      (VxState.store as MyStore).lstcamera = lst;
      return lst;
    } catch (e) {
      return lst;
    }
  }
}
