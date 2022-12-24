// ignore_for_file: prefer_final_fields

import 'package:flutter/cupertino.dart';
import 'package:live_streaming/Model/Admin/Camera/camera.dart';
import 'package:live_streaming/Model/Admin/venue.dart';

import '../Model/Admin/DVR/dvr.dart';

class DVRController extends ChangeNotifier {
  var _lstDVR = <DVR>[];
  var _lstchannel = <String>[];
  var _lstvenue = <Venue>[];
  var _lstvenueid = <int>[];
  var _lstCamera = <Camera>[];
  String? channel;
  String? venue;
  Venue? v;
  int? venueid;
  Camera? oldcamera;

  List<DVR> get lstDVR => _lstDVR;
  List<String> get lstchannel => _lstchannel;
  List<Camera> get lstCamera => _lstCamera;
  List<Venue> get lstvenue => _lstvenue;
  List<int> get lstvenueid => _lstvenueid;
  void newchannel(String channel) {
    this.channel = channel;
    notifyListeners();
  }

  void oldCamera(Camera c) {
    oldcamera = c;
    notifyListeners();
  }

  void newvenue(String v) {
    venue = v;
    notifyListeners();
  }

  void newVenue(Venue v) {
    this.v = v;
    notifyListeners();
  }

  void newvenueid(int v) {
    venueid = v;
    notifyListeners();
  }

  void dvrlist(List<DVR> dvr) {
    _lstDVR = dvr;
    notifyListeners();
  }

  void channellist(List<String> channel) {
    _lstchannel = channel;
    notifyListeners();
  }

  void venuelist(List<Venue> venue) {
    _lstvenue = venue;
    notifyListeners();
  }

  void dvrlistEmpty() {
    _lstDVR = [];
  }

  void channelEmpty() {
    _lstchannel = [];
  }

  void venueEmpty() {
    _lstvenue = [];
  }

  void venueincrement(Venue venue) {
    _lstvenue.add(venue);
    notifyListeners();
  }

  void venueidlist(List<int> venue) {
    _lstvenueid = venue;
    notifyListeners();
  }

  void venueidlistEmpty() {
    _lstvenueid = [];
  }

  void venueidincrement(int venue) {
    _lstvenueid.add(venue);
    notifyListeners();
  }

  // void dvrIncrement(DVR dvr) {
  //   _lstDVR.add(dvr);
  //   notifyListeners();
  // }

  void channelIncrement(String channel) {
    _lstchannel.add(channel);
    notifyListeners();
  }

  void cameraIncrement(Camera camera) {
    _lstCamera.add(camera);
    notifyListeners();
  }

  void cameralist(List<Camera> camera) {
    _lstCamera = camera;
    notifyListeners();
  }

  void cameralistEmpty() {
    _lstCamera = [];
  }
}
