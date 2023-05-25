// ignore_for_file: prefer_final_fields
import 'package:flutter/cupertino.dart';
import 'package:live_streaming/Model/Teacher/teacher_chr.dart';
import 'package:live_streaming/Model/user_error.dart';
import 'package:live_streaming/repo/Teacher/teacher_chr.dart';
import 'package:live_streaming/repo/api_status.dart';
import 'package:screenshot/screenshot.dart';

class TeacherCHRViewModel with ChangeNotifier {
  var _lstTeacherChr = <TeacherChr>[];
  bool _isloading = false;
  UserError? _userError;
  int selectedIndex = -1;
  int selectedTab = 0;
  bool isChr = true;
  bool isTeacherChr = true;
  bool isChrTable = false;
  bool isActivtyTable = false;
  String isTeacherTableSwitch = "";

  int selectedFilter = 0;
  ScreenshotController _screenshotController = ScreenshotController();

  List<TeacherChr> get lstTeacherChr => _lstTeacherChr;
  bool get isloading => _isloading;
  UserError? get userError => _userError;
  ScreenshotController get screenshotController => _screenshotController;

  TeacherCHRViewModel(String teacherName, {bool? isDirector}) {
    if (isDirector == null) {
      getTeacherCHR(teacherName);
    } else {
      getAllTeacherCHR();
    }
  }
  setListTeacherChr(List<TeacherChr> lst) {
    _lstTeacherChr = lst;
  }

  setIsChrTable() {
    isChrTable = !isChrTable;
    notifyListeners();
  }

  setIsTeacherChr(bool v) {
    isTeacherChr = v;
    notifyListeners();
  }

  setIsActivityTable() {
    isActivtyTable = !isActivtyTable;
    notifyListeners();
  }

  setIsTeacherTableSwitch(String v) {
    isTeacherTableSwitch = v;
    notifyListeners();
  }

  setIsChr() {
    isChr = !isChr;
    notifyListeners();
  }

  setSelectedFilter(int val) {
    selectedFilter = val;
    notifyListeners();
  }

  setSelectedTab(int val) {
    selectedTab = val;
    notifyListeners();
  }

  setUserError(UserError userError) {
    _userError = userError;
  }

  setloading(bool value) {
    _isloading = value;
    notifyListeners();
  }

  getTeacherCHR(String teacherName) async {
    setloading(true);
    _lstTeacherChr = [];
    _userError = null;
    var response = await TeacherCHRServies.getTeacherCHR(teacherName);
    if (response is Success) {
      setListTeacherChr(response.response as List<TeacherChr>);
    }
    if (response is Failure) {
      UserError userError =
          UserError(code: response.code, message: response.errorResponse);
      setUserError(userError);
    }
    setloading(false);
  }

  getAllTeacherCHR() async {
    setloading(true);
    _lstTeacherChr = [];
    _userError = null;
    var response = await TeacherCHRServies.getAllTeacherCHR();
    if (response is Success) {
      setListTeacherChr(response.response as List<TeacherChr>);
    }
    if (response is Failure) {
      UserError userError =
          UserError(code: response.code, message: response.errorResponse);
      setUserError(userError);
    }
    setloading(false);
  }
}
