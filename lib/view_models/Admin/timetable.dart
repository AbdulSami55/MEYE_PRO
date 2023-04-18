// ignore_for_file: prefer_final_fields, empty_catches

import 'package:flutter/material.dart';
import 'package:live_streaming/Model/Admin/timetable.dart';
import 'package:live_streaming/repo/Admin/timetable_services.dart';
import '../../Model/user_error.dart';
import '../../repo/api_status.dart';

class TimetableViewModel extends ChangeNotifier {
  bool _loading = true;
  var _lsttimetable = <TimeTable>[];
  var _lstTempTimeTable = <TimeTable>[];
  UserError? _userError;
  TimeTable? _timeTable;
  List<TimeTable> _lstSelectedTimeTable = [];
  bool _selectAll = false;
  String? selectedDiscipline;

  UserError? get userError => _userError;
  List<TimeTable> get lsttimetable => _lsttimetable;
  List<TimeTable> get lstTempTimeTable => _lstTempTimeTable;
  bool get loading => _loading;
  TimeTable? get timetable => _timeTable;
  List<TimeTable> get lstSelectedTimeTable => _lstSelectedTimeTable;
  bool get selectAll => _selectAll;

  setSelectedDiscipline(String value) {
    selectedDiscipline = value;
    notifyListeners();
  }

  setSelectAll(bool val) {
    _selectAll = val;
    if (_selectAll) {
      for (TimeTable i in _lstTempTimeTable) {
        i.isSelected = true;
      }
    } else {
      for (TimeTable i in _lstTempTimeTable) {
        i.isSelected = false;
      }
    }
    notifyListeners();
  }

  TimetableViewModel(String teacherName) {
    if (teacherName.split(' ')[0] == "Mr") {
      teacherName = teacherName.substring(3, teacherName.length);
    }
    getdata(teacherName);
  }

  List<DropdownMenuItem<String>> getTeacherDiscipline() {
    List<String> lst = [];
    for (TimeTable timeTable in _lsttimetable) {
      if (!lst.contains(timeTable.discipline)) {
        lst.add(timeTable.discipline);
      }
    }
    return lst
        .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
        .toList();
  }

  void setListTempTimeTable(TimeTable timeTable) {
    _lstTempTimeTable.add(timeTable);
  }

  void setlsttimetable(List<TimeTable> lst) {
    _lsttimetable = lst;
  }

  void emptylst() {
    _userError = null;
    _lstTempTimeTable = [];
  }

  updateValue(TimeTable timeTableData) {
    timeTableData.isSelected = !timeTableData.isSelected;
    if (timeTableData.isSelected) {
      _lstSelectedTimeTable.add(timeTableData);
    } else {
      _lstSelectedTimeTable.remove(timeTableData);
    }
    notifyListeners();
  }

  void setdata(List<TimeTable> lst) {
    _lsttimetable = lst;
    selectedDiscipline = lst[0].discipline;
  }

  void setloading(bool load) {
    _loading = load;
    try {
      notifyListeners();
    } catch (e) {}
  }

  void setUserError(UserError userError) {
    _userError = userError;
  }

  getdata(String teacherName) async {
    setloading(true);
    var response = await TimeTableServices().gettimetable(teacherName);
    if (response is Success) {
      setdata(response.response as List<TimeTable>);
    }
    if (response is Failure) {
      UserError userError =
          UserError(code: response.code, message: response.errorResponse);
      setUserError(userError);
    }
    setloading(false);
  }
}
