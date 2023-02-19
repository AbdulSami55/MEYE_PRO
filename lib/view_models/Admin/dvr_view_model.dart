// ignore_for_file: prefer_final_fields

import 'package:flutter/cupertino.dart';
import 'package:live_streaming/Model/user_error.dart';
import 'package:live_streaming/repo/api_status.dart';
import 'package:live_streaming/repo/Admin/dvr_services.dart';
import 'package:live_streaming/view_models/Admin/venue_view_model.dart';
import '../../Model/Admin/dvr.dart';

class DVRViewModel extends ChangeNotifier {
  bool _isloading = false;
  var _lstDVR = <DVR>[];
  UserError? _userError;
  DVR _adddvr = DVR();

  bool get loading => _isloading;
  List<DVR> get lstDVR => _lstDVR;
  UserError? get userError => _userError;
  DVR get adddvr => _adddvr;

  DVRViewModel() {
    getDvrData();
  }
  setloading(bool loading) async {
    _isloading = loading;
    notifyListeners();
  }

  void setDvrList(List<DVR> lst) {
    _lstDVR = lst;
  }

  void setUserError(UserError userError) {
    _userError = userError;
  }

  void addDvr(DVR dvr) {
    if (isValid()) {
      _lstDVR.add(dvr);
      dvr = DVR();
    }
  }

  isValid() {
    if (adddvr.channel == null ||
        adddvr.host == null ||
        adddvr.ip == null ||
        adddvr.name == null) {
      return false;
    }
    return true;
  }

  getDvrData() async {
    setloading(true);
    var response = await DVRServices.getDvr();
    if (response is Success) {
      setDvrList(response.response as List<DVR>);
      VenueViewModel().getVenueData();
    }
    if (response is Failure) {
      UserError userError =
          UserError(code: response.code, message: response.errorResponse);
      setUserError(userError);
    }
    setloading(false);
  }

  void dvrlistEmpty() {
    _lstDVR = [];
  }
}
