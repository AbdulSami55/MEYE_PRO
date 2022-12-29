// ignore_for_file: prefer_final_fields

import 'package:flutter/cupertino.dart';
import 'package:live_streaming/Model/Admin/venue.dart';
import 'package:live_streaming/Model/user_error.dart';
import 'package:live_streaming/repo/api_status.dart';
import 'package:live_streaming/repo/camera_service.dart';

import '../Model/Admin/camera.dart';
import '../Model/Admin/dvr.dart';

class CameraViewModel extends ChangeNotifier {
  bool _isloading = false;
  var _lstchannel = <String>[];
  var _lstvenue = <Venue>[];
  var _lstvenueid = <int>[];
  var _lstCamera = <Camera>[];

  String? venue;
  Venue? v;
  int? venueid;
  Camera? oldcamera;
  UserError? _userError;
  int? did;
  Camera _addcamera = Camera();

  bool get loading => _isloading;
  UserError? get userError => _userError;
  List<String> get lstchannel => _lstchannel;
  List<Camera> get lstCamera => _lstCamera;
  List<Venue> get lstvenue => _lstvenue;
  List<int> get lstvenueid => _lstvenueid;
  Camera get addcamera => _addcamera;

  CameraViewModel(DVR dvr) {
    did = dvr.id;
    addchannels(dvr);
    getCameraData();
  }
  setloading(bool loading) async {
    _isloading = loading;
    notifyListeners();
  }

  void setCameraList(List<Camera> lst) {
    _lstCamera = lst;
    for (var i in lst) {
      if (_lstchannel.contains(i.no)) {
        _lstchannel.remove(i.no);
      }
    }
  }

  void addchannels(DVR dvr) {
    int channel = int.parse(dvr.channel.toString());
    for (int i = 1; i <= channel; i++) {
      _lstchannel.add(i.toString());
    }
  }

  void setUserError(UserError userError) {
    _userError = userError;
  }

  void addDvr(Camera camera) {
    if (isValid()) {
      _lstCamera.add(camera);
      camera = Camera();
    }
  }

  isValid() {
    if (addcamera.did == null ||
        addcamera.vid == null ||
        addcamera.no == null) {
      return false;
    }
    return true;
  }

  getCameraData() async {
    setloading(true);
    var response = await CameraServies.getCamera(did!);
    if (response is Success) {
      setCameraList(response.response as List<Camera>);
    }
    if (response is Failure) {
      UserError userError =
          UserError(code: response.code, message: response.errorResponse);
      setUserError(userError);
    }
    setloading(false);
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

  void channellist(List<String> channel) {
    _lstchannel = channel;
    notifyListeners();
  }

  void venuelist(List<Venue> venue) {
    _lstvenue = venue;
    notifyListeners();
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
