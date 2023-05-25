// ignore_for_file: prefer_final_fields

import 'package:flutter/cupertino.dart';
import 'package:live_streaming/Model/Admin/rules.dart';
import 'package:live_streaming/Model/user_error.dart';
import 'package:live_streaming/repo/api_status.dart';
import 'package:live_streaming/repo/Admin/dvr_services.dart';

class RulesViewModel extends ChangeNotifier {
  bool _isloading = false;
  var _lstRules = <Rules>[];
  UserError? _userError;

  bool get loading => _isloading;
  List<Rules> get lstRules => _lstRules;
  UserError? get userError => _userError;

  setloading(bool loading) async {
    _isloading = loading;
    notifyListeners();
  }

  void setRulesList(List<Rules> lst) {
    _lstRules = lst;
  }

  void setUserError(UserError userError) {
    _userError = userError;
  }

  getDvrData() async {
    setloading(true);
    var response = await DVRServices.getDvr();
    if (response is Success) {
      setRulesList(response.response as List<Rules>);
    }
    if (response is Failure) {
      UserError userError =
          UserError(code: response.code, message: response.errorResponse);
      setUserError(userError);
    }
    setloading(false);
  }

  void ruleslistEmpty() {
    _lstRules = [];
  }
}
