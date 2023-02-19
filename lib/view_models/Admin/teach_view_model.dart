// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:live_streaming/Model/Admin/teach.dart';
import 'package:live_streaming/repo/Admin/teach_services.dart';
import 'package:live_streaming/view_models/Admin/timetable.dart';
import 'package:provider/provider.dart';

import '../../Model/user_error.dart';
import '../../repo/api_status.dart';

class TeachViewModel extends ChangeNotifier {
  bool _loading = true;
  var _lstteach = <Teach>[];
  UserError? _userError;

  UserError? get userError => _userError;
  List<Teach> get lstteach => _lstteach;
  bool get loading => _loading;

  TeachViewModel(int id, BuildContext context) {
    getdata(id, context);
  }
  void setlstteach(List<Teach> lst, BuildContext context) async {
    _lstteach = lst;
    Provider.of<TimetableViewModel>(context, listen: false).emptylst();
    for (Teach t in lst) {
      await Provider.of<TimetableViewModel>(context, listen: false)
          .getdata(t.timeTableID!);
    }
  }

  void setloading(bool load) {
    _loading = load;
    notifyListeners();
  }

  void setUserError(UserError userError) {
    _userError = userError;
  }

  void getdata(int id, BuildContext context) async {
    setloading(true);
    var response = await TeachServices().getteach(id);
    if (response is Success) {
      setlstteach(response.response as List<Teach>, context);
    }
    if (response is Failure) {
      UserError userError =
          UserError(code: response.code, message: response.errorResponse);
      setUserError(userError);
    }
    setloading(false);
  }
}
