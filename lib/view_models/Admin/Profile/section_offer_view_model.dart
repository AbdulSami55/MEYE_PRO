// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:live_streaming/Model/Admin/section_offer.dart';
import 'package:live_streaming/Model/user_error.dart';
import 'package:live_streaming/repo/Admin/section_offer_services.dart';
import 'package:live_streaming/repo/api_status.dart';

class SectionOfferViewModel with ChangeNotifier {
  List<SectionOffer> _lstSectionOffer = [];
  bool _isloading = false;
  UserError? _userError;
  Set<String> _lstDiscipline = {};
  List<DropdownMenuItem<String>> _lstCourseDropdown = [];
  List<SectionOffer> _lstCourses = [];
  String _selectedValue = "";

  List<SectionOffer> get lstSectionOffer => _lstSectionOffer;
  bool get isloading => _isloading;
  UserError? get userError => _userError;
  Set<String> get lstDiscipline => _lstDiscipline;
  List<DropdownMenuItem<String>> get lstCourseDropdown => _lstCourseDropdown;
  String get selectedValue => _selectedValue;
  List<SectionOffer> get lstCourses => _lstCourses;

  SectionOfferViewModel() {
    getData();
  }

  setListSectionOffer(List<SectionOffer> lst) {
    _lstSectionOffer = lst;
    for (SectionOffer sectionOffer in lst) {
      _lstDiscipline.add(sectionOffer.discipline);
    }
    _lstCourseDropdown = _lstDiscipline
        .map((e) => DropdownMenuItem(
              value: e,
              child: Text(e),
            ))
        .toList();
    _selectedValue = _lstDiscipline.first;
    _lstCourses =
        _lstSectionOffer.where((e) => e.discipline == selectedValue).toList();
  }

  setSelectedValue(String value) {
    _selectedValue = value;
    _lstCourses =
        _lstSectionOffer.where((e) => e.discipline == selectedValue).toList();

    notifyListeners();
  }

  void setUserError(UserError userError) {
    _userError = userError;
  }

  setloading(bool loading) {
    _isloading = loading;
    notifyListeners();
  }

  changeCourse(int index) {
    _lstCourses[index].isSelected = !_lstCourses[index].isSelected;
    notifyListeners();
  }

  getData() async {
    setloading(true);
    var response = await SectionOfferServies.getSectionOfferCourses();
    if (response is Success) {
      setListSectionOffer(response.response as List<SectionOffer>);
    }
    if (response is Failure) {
      UserError userError =
          UserError(code: response.code, message: response.errorResponse);
      setUserError(userError);
    }
    setloading(false);
  }
}
