import 'package:flutter/material.dart';
import 'package:live_streaming/Model/demo.dart';
import 'package:live_streaming/Model/user_error.dart';
import 'package:live_streaming/repo/api_status.dart';
import 'package:live_streaming/repo/demo_services.dart';

class DemoViewModel extends ChangeNotifier {
  var _lstDemo = <Demo>[];
  bool _isloading = false;
  UserError? _userError;
  DemoDetails? _demoDetails;

  bool get isloading => _isloading;
  UserError? get userError => _userError;
  List<Demo> get lstDemo => _lstDemo;
  DemoDetails? get demoDetails => _demoDetails;

  DemoViewModel() {
    getallDemoVideo();
  }
  void setDemoDetails(DemoDetails demoDetails) {
    _demoDetails = demoDetails;
  }

  void setListDemo(List<Demo> lst) {
    _lstDemo = lst;
  }

  void setloading(bool load) {
    _isloading = load;
    notifyListeners();
  }

  void setUserError(UserError userError) {
    _userError = userError;
  }

  Future getallDemoVideo() async {
    _userError = null;
    setloading(true);
    var response = await DemoServies.getAllDemoVideo();
    if (response is Success) {
      setListDemo(response.response as List<Demo>);
    }
    if (response is Failure) {
      UserError userError =
          UserError(code: response.code, message: response.errorResponse);
      setUserError(userError);
    }
    setloading(false);
  }

  Future getDemoVideoDetails(String fileName) async {
    _userError = null;
    setloading(true);
    var response = await DemoServies.getDemoVideoDetails(fileName);
    if (response is Success) {
      setDemoDetails(response.response as DemoDetails);
    }
    if (response is Failure) {
      UserError userError =
          UserError(code: response.code, message: response.errorResponse);
      setUserError(userError);
    }
    setloading(false);
  }
}
