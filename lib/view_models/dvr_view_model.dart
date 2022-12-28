// ignore_for_file: prefer_final_fields

import 'package:flutter/cupertino.dart';
import 'package:live_streaming/Model/Admin/venue.dart';
import 'package:live_streaming/Model/user_error.dart';
import 'package:live_streaming/repo/api_status.dart';
import 'package:live_streaming/repo/dvr_services.dart';

import '../Model/Admin/camera.dart';
import '../Model/Admin/dvr.dart';

class DVRViewModel extends ChangeNotifier {
  bool _isloading = false;
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
  UserError? _userError;
  DVR _adddvr = DVR();

  bool get loading => _isloading;
  List<DVR> get lstDVR => _lstDVR;
  UserError? get userError => _userError;
  List<String> get lstchannel => _lstchannel;
  List<Camera> get lstCamera => _lstCamera;
  List<Venue> get lstvenue => _lstvenue;
  List<int> get lstvenueid => _lstvenueid;
  DVR get adddvr => _adddvr;

  DVRViewModel() {
    getDvrData();
  }
  setloading(bool loading) async {
    _isloading = loading;
    notifyListeners();
  }

  void setDvrList(List<DVR> lst) {
    _lstDVR = lst;
  }

  void setUserError(UserError userError) {
    _userError = userError;
  }

  void addDvr(DVR dvr) {
    if (isValid()) {
      _lstDVR.add(dvr);
      dvr = DVR();
    }
  }

  isValid() {
    if (adddvr.channel == null ||
        adddvr.host == null ||
        adddvr.ip == null ||
        adddvr.name == null) {
      return false;
    }
    return true;
  }

  getDvrData() async {
    setloading(true);
    var response = await DVRServices.getDvr();
    if (response is Success) {
      setDvrList(response.response as List<DVR>);
    }
    if (response is Failure) {
      UserError userError =
          UserError(code: response.code, message: response.errorResponse);
      setUserError(userError);
    }
    setloading(false);
  }

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
