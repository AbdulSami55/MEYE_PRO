import 'package:flutter/cupertino.dart';

class BottomNavViewModel with ChangeNotifier {
  int _teacherSelectedValue = 0;
  int get teacherSelectedValue => _teacherSelectedValue;

  int _adminSelectedValue = 0;
  int get adminSelectedValue => _adminSelectedValue;

  setTeacherSelectValue(int value) {
    _teacherSelectedValue = value;
    notifyListeners();
  }

  setAdminSelectValue(int value) {
    _adminSelectedValue = value;
    notifyListeners();
  }
}
