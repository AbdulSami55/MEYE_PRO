import 'package:flutter/cupertino.dart';
import 'package:live_streaming/Model/Admin/student.dart';
import 'package:live_streaming/Model/user_error.dart';
import 'package:live_streaming/repo/Admin/user_service.dart';
import 'package:live_streaming/repo/api_status.dart';

class StudentViewModel with ChangeNotifier {
  List<Student> _lstStudent = <Student>[];
  bool _isloading = false;
  UserError? _userError;

  List<Student> get lstStudent => _lstStudent;
  bool get isloading => _isloading;
  UserError? get userError => _userError;

  StudentViewModel() {
    getData();
  }

  setListStudent(List<Student> lst) {
    _lstStudent = lst;
  }

  changeStudent(int index) {
    _lstStudent[index].isSelected = !_lstStudent[index].isSelected!;
    notifyListeners();
  }

  void setUserError(UserError userError) {
    _userError = userError;
  }

  setloading(bool loading) {
    _isloading = loading;
    notifyListeners();
  }

  getData() async {
    setloading(true);
    var response = await UserServies.getStudent();
    if (response is Success) {
      setListStudent(response.response as List<Student>);
    }
    if (response is Failure) {
      UserError userError =
          UserError(code: response.code, message: response.errorResponse);
      setUserError(userError);
    }
    setloading(false);
  }
}
