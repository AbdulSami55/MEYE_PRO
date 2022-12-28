// ignore_for_file: constant_identifier_names, file_names

import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:live_streaming/Model/Admin/venue.dart';
import 'package:provider/provider.dart';

import '../Model/Admin/camera.dart';
import '../utilities/constants.dart';
import '../view_models/dvr_view_model.dart';

enum CameraDetailsAction { Fetch }

class CameraDetailsBloc {
  static List<Camera> lst = [];
  Camera? c;
  static int? index;
  int? id;
  BuildContext? context;
  final _stateCameraDetailsController =
      StreamController<List<Camera>>.broadcast();
  StreamSink<List<Camera>> get _sinkCameraDetails =>
      _stateCameraDetailsController.sink;
  Stream<List<Camera>> get streamCameraDetails =>
      _stateCameraDetailsController.stream;

  final _eventCameraDetailsController =
      StreamController<CameraDetailsAction>.broadcast();
  StreamSink<CameraDetailsAction> get eventsinkCameraDetails =>
      _eventCameraDetailsController.sink;
  Stream<CameraDetailsAction> get _eventstreamCameraDetails =>
      _eventCameraDetailsController.stream;

  CameraDetailsBloc() {
    _eventstreamCameraDetails.listen((event) async {
      if (event == CameraDetailsAction.Fetch) {
        try {
          var data = await getData(id!, index!, context!);
          _sinkCameraDetails.add(data);
        } catch (e) {
          _sinkCameraDetails.addError("Something Went Wrong..");
        }
      }
    });
  }

  Future<List<Camera>> getData(int did, int index, BuildContext context) async {
    lst = [];
    Provider.of<DVRViewModel>(context, listen: false).cameralistEmpty();
    try {
      await http
          .get(Uri.parse('$baseUrl/api/camera-details/$did'))
          .then((response) {
        if (response.statusCode == 200) {
          lst = [];
          Provider.of<DVRViewModel>(context, listen: false).channelEmpty();
          Provider.of<DVRViewModel>(context, listen: false).venueEmpty();
          Provider.of<DVRViewModel>(context, listen: false).venueidlistEmpty();
          int count = int.parse(
              Provider.of<DVRViewModel>(context, listen: false)
                  .lstDVR[index]
                  .channel!);
          for (int i = 1; i <= count; i++) {
            Provider.of<DVRViewModel>(context, listen: false)
                .lstchannel
                .add(i.toString());
          }
          var data = json.decode(response.body);
          for (var i in data["data"]) {
            Camera c = Camera.fromJson(i);
            Provider.of<DVRViewModel>(context, listen: false)
                .lstchannel
                .remove(c.no);
            lst.add(c);
            Provider.of<DVRViewModel>(context, listen: false).lstCamera.add(c);
          }
        }
      });

      await http.get(Uri.parse('$baseUrl/api/venue-details')).then((response) {
        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          for (var i in data["data"]) {
            Venue v = Venue.fromjson(i);
            Provider.of<DVRViewModel>(context, listen: false).lstvenue.add(v);
            Provider.of<DVRViewModel>(context, listen: false)
                .lstvenueid
                .add(v.id);
          }
        }
      });

      return lst;
    } catch (e) {
      return lst;
    }
  }

  void dispose() {
    _eventCameraDetailsController.close();
    _stateCameraDetailsController.close();
  }
}
