// ignore_for_file: unused_field, prefer_final_fields
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:live_streaming/Model/Admin/user.dart';
import 'package:live_streaming/repo/Admin/user_service.dart';
import 'package:live_streaming/repo/api_status.dart';
// import 'package:ml_linalg/linalg.dart';

import '../../../Model/user_error.dart';

class UserViewModel extends ChangeNotifier {
  bool _isloading = true;
  var _lstuser = <User>[];
  File? _file;
  UserError? _userError;
  String _selectedrole = "Teacher";
  User? _user;
  bool _signinloading = false;

  String get selectedrole => _selectedrole;
  List<User> get lstuser => _lstuser;
  bool get isloading => _isloading;
  bool get signinloading => _signinloading;
  UserError? get userError => _userError;
  File? get file => _file;
  User get user => _user!;

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

  void setUser(User user) {
    _user = user;
  }

  setSigninLoading(bool value) {
    _signinloading = value;
    notifyListeners();
  }

  void getUserdata() async {
    _userError = null;
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

  Future<void> refreshPage() {
    return Future.delayed(const Duration(milliseconds: 1))
        .then((value) => getUserdata());
  }

  Future insertUserdata(User u, File file) async {
    var response = await UserServies.post(u, file);
    if (response is Success) {
      return response.response;
    }
    if (response is Failure) {
      return response.errorResponse;
    }
  }
}
