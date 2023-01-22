// ignore_for_file: prefer_final_fields

import 'package:flutter/cupertino.dart';
import 'package:live_streaming/Model/user_error.dart';
import 'package:live_streaming/repo/api_status.dart';
import 'package:live_streaming/repo/Admin/camera_service.dart';

import '../Model/Admin/camera.dart';
import '../Model/Admin/dvr.dart';

class CameraViewModel extends ChangeNotifier {
  bool _isloading = false;
  var _lstchannel = <String>[];
  var _lstvenueid = <int>[];
  var _lstCamera = <Camera>[];

  UserError? _userError;
  int? did;
  Camera _addcamera = Camera();

  bool get loading => _isloading;
  UserError? get userError => _userError;
  List<String> get lstchannel => _lstchannel;
  List<Camera> get lstCamera => _lstCamera;

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

  void channellist(List<String> channel) {
    _lstchannel = channel;
    notifyListeners();
  }
}
