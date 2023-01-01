import 'package:flutter/cupertino.dart';
import 'package:live_streaming/Model/Admin/user.dart';
import 'package:live_streaming/repo/Admin/user_service.dart';
import 'package:live_streaming/repo/api_status.dart';

import '../Model/user_error.dart';

class UserViewModel extends ChangeNotifier {
  bool _isloading = true;
  var _lstuser = <User>[];
  UserError? _userError;
  List<User> get lstuser => _lstuser;
  bool get isloading => _isloading;
  UserError? get userError => _userError;

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
}
