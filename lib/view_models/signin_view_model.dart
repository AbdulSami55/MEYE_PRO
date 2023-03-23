// ignore_for_file: unused_field, prefer_final_fields

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:live_streaming/Model/Admin/user.dart';
import 'package:live_streaming/repo/Admin/user_service.dart';
import 'package:live_streaming/repo/api_status.dart';
// import 'package:ml_linalg/linalg.dart';

import '../../../Model/user_error.dart';

class SignInViewModel extends ChangeNotifier {
  bool _isloading = false;
  UserError? _userError;
  User? _user;

  bool get isloading => _isloading;
  UserError? get userError => _userError;
  User get user => _user!;

  void setloading(bool load) {
    _isloading = load;
    notifyListeners();
  }

  void setUserError(UserError userError) {
    _userError = userError;
  }

  void setUser(User user) {
    _user = user;
  }

  Future signin(String userId, String password) async {
    _userError = null;
    _user = null;
    var response = await UserServies.SignIn(userId, password);
    if (response is Success) {
      var data = json.decode(response.response as String);
      if (data != "Invalid Password" && data != "User Not Found") {
        User user = User.fromJson(data);
        setUser(user);
        return "move";
      } else {
        UserError userError = UserError(code: response.code, message: data);
        setUserError(userError);
      }
    }
    if (response is Failure) {
      UserError userError =
          UserError(code: response.code, message: response.errorResponse);
      setUserError(userError);
    }
    return "done";
  }
}
