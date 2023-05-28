// ignore_for_file: prefer_final_fields, empty_catches

import 'package:flutter/material.dart';
import 'package:live_streaming/Model/Admin/rules_timeTable.dart';
import 'package:live_streaming/Model/Admin/timetable.dart';
import 'package:live_streaming/repo/Admin/rules_services.dart';
import 'package:live_streaming/repo/Admin/timetable_services.dart';
import 'package:live_streaming/view_models/Admin/Profile/rule_setting_view_model.dart';
import '../../Model/user_error.dart';
import '../../repo/api_status.dart';

class TimetableViewModel extends ChangeNotifier {
  bool _loading = true;
  var _lsttimetable = <TimeTable>[];
  var _lstrulestimetable = <RulesTimeTable>[];
  var _lstTempTimeTable = <RulesTimeTable>[];
  UserError? _userError;
  TimeTable? _timeTable;
  List<RulesTimeTable> _lstSelectedTimeTable = [];
  bool _selectAll = false;
  String? selectedDiscipline;

  UserError? get userError => _userError;
  List<TimeTable> get lsttimetable => _lsttimetable;
  List<RulesTimeTable> get lstrulestimetable => _lstrulestimetable;
  List<RulesTimeTable> get lstTempTimeTable => _lstTempTimeTable;
  bool get loading => _loading;
  TimeTable? get timetable => _timeTable;
  List<RulesTimeTable> get lstSelectedTimeTable => _lstSelectedTimeTable;
  bool get selectAll => _selectAll;
  RuleSettingViewModel? rulesViewModel;

  setSelectedDiscipline(String value) {
    selectedDiscipline = value;
    notifyListeners();
  }

  setSelectAll(bool val) {
    _selectAll = val;
    _lstSelectedTimeTable = [];
    if (_selectAll) {
      for (RulesTimeTable i in _lstTempTimeTable) {
        i.isSelected = true;
        _lstSelectedTimeTable.add(i);
      }
    } else {
      for (RulesTimeTable i in _lstTempTimeTable) {
        i.isSelected = false;
      }
    }
    notifyListeners();
  }

  TimetableViewModel(String teacherName,
      {bool? isRule, RuleSettingViewModel? ruleSettingViewModel}) {
    if (teacherName.split(' ')[0] == "Mr") {
      teacherName = teacherName.substring(3, teacherName.length);
    }
    if (isRule == null) {
      getdata(teacherName);
    } else {
      rulesViewModel = ruleSettingViewModel;
      getRulesData(teacherName);
    }
  }

  List<DropdownMenuItem<String>> getTeacherDiscipline() {
    Set<String> lst = {};
    for (TimeTable timeTable in _lsttimetable) {
      lst.add(timeTable.discipline);
    }
    return lst
        .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
        .toList();
  }

  void setListTempTimeTable(RulesTimeTable timeTable) {
    _lstTempTimeTable.add(timeTable);
  }

  void setlsttimetable(List<TimeTable> lst) {
    _lsttimetable = lst;
  }

  void emptylst() {
    _userError = null;
    _lstTempTimeTable = [];
  }

  updateValue(RulesTimeTable timeTableData) {
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

  void setRulesData(RulesData rulesData) {
    if (rulesData.startRecord) {
      rulesViewModel!.setFirst(true);
    } else {
      rulesViewModel!.setFirst(false);
    }
    if (rulesData.midRecord) {
      rulesViewModel!.setMid(true);
    } else {
      rulesViewModel!.setMid(false);
    }
    if (rulesData.endRecord) {
      rulesViewModel!.setLast(true);
    } else {
      rulesViewModel!.setLast(false);
    }
    if (rulesData.fullRecord) {
      rulesViewModel!.setFull(true);
    } else {
      rulesViewModel!.setFull(false);
    }
    _lstrulestimetable = rulesData.rulesTimeTable;
    _lstSelectedTimeTable = [];
    for (RulesTimeTable element in _lstrulestimetable) {
      if (element.isSelected) {
        _lstSelectedTimeTable.add(element);
      }
    }
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

  getRulesData(String teacherName) async {
    setloading(true);
    var response = await RulesServices().getRulesTimeTable(teacherName);
    if (response is Success) {
      setRulesData(response.response as RulesData);
    }
    if (response is Failure) {
      UserError userError =
          UserError(code: response.code, message: response.errorResponse);
      setUserError(userError);
    }
    setloading(false);
  }
}
