// ignore_for_file: prefer_final_fields

import 'package:flutter/cupertino.dart';
import 'package:live_streaming/Model/Admin/enroll.dart';
import 'package:live_streaming/Model/Admin/student.dart';
import 'package:live_streaming/Model/user_error.dart';
import 'package:live_streaming/repo/Admin/section_offer_services.dart';
import 'package:live_streaming/repo/api_status.dart';

class StudentViewModel with ChangeNotifier {
  List<Student> _lstStudent = <Student>[];
  bool _isloading = false;
  UserError? _userError;
  List<Enroll> _lstEnroll = <Enroll>[];

  List<Student> get lstStudent => _lstStudent;
  bool get isloading => _isloading;
  UserError? get userError => _userError;
  List<Enroll> get lstEnroll => _lstEnroll;

  StudentViewModel({List<String>? lstcourse}) {
    if (lstcourse != null) {
      getData(lstcourse);
    }
  }

  setEnroll(Enroll enroll) {
    _lstEnroll.add(enroll);
  }

  setListStudent(List<Student> lst) {
    _lstStudent = lst;
  }

  changeStudent(int index, List<int> sectionOfferId) {
    _lstStudent[index].isSelected = !_lstStudent[index].isSelected!;
    if (_lstStudent[index].isSelected!) {
      Enroll e = Enroll(
          id: 0,
          sectionOfferId: sectionOfferId,
          studentId: _lstStudent[index].aridNo);
      _lstEnroll.add(e);
    } else {
      _lstEnroll.remove(_lstEnroll
          .where((e) => e.studentId == _lstStudent[index].aridNo)
          .first);
    }
    notifyListeners();
  }

  void setUserError(UserError userError) {
    _userError = userError;
  }

  setloading(bool loading) {
    _isloading = loading;
    notifyListeners();
  }

  getData(List<String> lstcourse) async {
    setloading(true);
    var response = await SectionOfferServies.getStudentOfferCourses(lstcourse);
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
