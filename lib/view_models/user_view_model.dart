// ignore_for_file: unused_field, prefer_final_fields

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:live_streaming/Model/Admin/user.dart';
import 'package:live_streaming/repo/Admin/user_service.dart';
import 'package:live_streaming/repo/api_status.dart';
// import 'package:ml_linalg/linalg.dart';

import '../Model/user_error.dart';

class UserViewModel extends ChangeNotifier {
  bool _isloading = true;
  var _lstuser = <User>[];
  File? _file;
  UserError? _userError;
  String _selectedrole = "Teacher";

  String get selectedrole => _selectedrole;
  List<User> get lstuser => _lstuser;
  bool get isloading => _isloading;
  UserError? get userError => _userError;
  File? get file => _file;

  UserViewModel() {
    getUserdata();
  }
  void lstuserAdd(List<User> lst) {
    _lstuser = lst;
  }

  void setloading(bool load) {
    _isloading = load;
    notifyListeners();
  }

  void changeSelectedRole(String val) {
    _selectedrole = val;
    notifyListeners();
  }

  void addUserImage(File file) {
    _file = file;
    notifyListeners();
  }

  void setUserError(UserError userError) {
    _userError = userError;
  }

  void getUserdata() async {
    setloading(true);
    var response = await UserServies.getUser();
    if (response is Success) {
      lstuserAdd(response.response as List<User>);
    }
    if (response is Failure) {
      UserError userError =
          UserError(code: response.code, message: response.errorResponse);
      setUserError(userError);
    }
    setloading(false);
  }

  var vector = [
    -0.15451247,
    0.10567529,
    0.12015495,
    -0.04090233,
    -0.0783975,
    -0.00848038,
    -0.05148856,
    -0.00158618,
    0.10493097,
    -0.03150025,
    0.19113669,
    0.03229779,
    -0.21659788,
    -0.01117466,
    -0.04117122,
    0.09780984,
    -0.13280952,
    -0.10680985,
    0.01246836,
    -0.12275828,
    0.08704381,
    0.06108743,
    -0.04080063,
    0.02899963,
    -0.19552262,
    -0.32969084,
    -0.07264187,
    -0.09351617,
    -0.01723525,
    -0.14287399,
    0.00105955,
    -0.02667698,
    -0.12475443,
    0.00081233,
    0.01307689,
    0.10200837,
    0.00247304,
    -0.05392289,
    0.18251896,
    0.04503211,
    -0.1006297,
    0.03310518,
    0.05171914,
    0.3048847,
    0.12983918,
    0.07084116,
    0.04789515,
    -0.06886183,
    0.13360521,
    -0.25970355,
    0.12302725,
    0.13909434,
    0.08359889,
    0.05960537,
    0.05142421,
    -0.11981315,
    -0.0214176,
    0.07572634,
    -0.17449364,
    0.07132144,
    0.06517226,
    -0.00347565,
    0.00488054,
    -0.0515454,
    0.20278321,
    0.13580608,
    -0.1551268,
    -0.0600261,
    0.04526651,
    -0.18635462,
    -0.07964332,
    -0.01295051,
    -0.08094614,
    -0.12088068,
    -0.30201527,
    0.10918813,
    0.39433116,
    0.14941698,
    -0.17467064,
    -0.03949367,
    -0.08720944,
    -0.0042104,
    0.09635479,
    0.0529676,
    -0.1634278,
    0.01127278,
    -0.08883943,
    0.07403877,
    0.21526806,
    0.05111981,
    -0.03640566,
    0.18453109,
    0.04451616,
    0.10982946,
    0.03154226,
    0.09522692,
    -0.15133907,
    -0.05037126,
    -0.05559672,
    0.01009609,
    0.01788846,
    -0.04305929,
    0.04071172,
    0.18022946,
    -0.19313724,
    0.14374053,
    -0.03472419,
    -0.04657791,
    -0.01259597,
    0.10075065,
    -0.13665193,
    -0.08525303,
    0.10684027,
    -0.1861971,
    0.10013353,
    0.17374371,
    -0.01243623,
    0.13127324,
    0.1130378,
    0.05266136,
    -0.04317256,
    -0.00178122,
    -0.1060067,
    -0.02850793,
    0.03092479,
    0.00048216,
    0.08266255,
    0.0153413
  ];
  int count = 0;
  void insertUserdata(User u, File file) async {
    setloading(true);
    var response = await UserServies.post(u, file);
    if (response is Success) {
      List val = response.response as List;

      List<double> lst = [];
      for (var i in val) {
        lst.add(double.parse(i.toString()));
      }
      // final vector1 = Vector.fromList(lst);
      // final v = Vector.fromList(vector);
      // final vector2 = v - vector1;
      // if (vector2.norm() < 0.6) {
      //   print("match");
      // } else {
      //   print("not match");
      // }
    }
    if (response is Failure) {
      UserError userError =
          UserError(code: response.code, message: response.errorResponse);
      setUserError(userError);
    }
    setloading(false);
  }
}
