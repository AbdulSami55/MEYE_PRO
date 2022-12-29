// ignore_for_file: prefer_final_fields

import 'package:flutter/cupertino.dart';
import 'package:live_streaming/Model/Admin/venue.dart';
import 'package:live_streaming/Model/user_error.dart';
import 'package:live_streaming/repo/api_status.dart';
import 'package:live_streaming/repo/venue_service.dart';

class VenueViewModel extends ChangeNotifier {
  bool _isloading = false;
  var _lstchannel = <String>[];
  var _lstvenue = <Venue>[];
  var _lstvenueid = <int>[];

  String? channel;
  String? venue;
  Venue? selectedvenue;
  int? venueid;
  UserError? _userError;
  int? did;
  Venue _addvenue = Venue();
  String? selectedchannel;

  bool get loading => _isloading;
  UserError? get userError => _userError;
  List<String> get lstchannel => _lstchannel;
  List<Venue> get lstvenue => _lstvenue;
  List<int> get lstvenueid => _lstvenueid;
  Venue get addvenue => _addvenue;

  VenueViewModel() {
    getVenueData();
  }

  setloading(bool loading) async {
    _isloading = loading;
    notifyListeners();
  }

  void setVenueList(List<Venue> lst) {
    _lstvenue = lst;
  }

  void setUserError(UserError userError) {
    _userError = userError;
  }

  void addDvr(Venue venue) {
    if (isValid()) {
      _lstvenue.add(venue);
      venue = Venue();
    }
  }

  isValid() {
    if (addvenue.name == null) {
      return false;
    }
    return true;
  }

  getVenueData() async {
    setloading(true);
    var response = await VenueServies.getVenue();
    if (response is Success) {
      setVenueList(response.response as List<Venue>);
    }
    if (response is Failure) {
      UserError userError =
          UserError(code: response.code, message: response.errorResponse);
      setUserError(userError);
    }
    setloading(false);
  }

  void newvenue(String v) {
    venue = v;
    notifyListeners();
  }

  void newVenue(Venue v) {
    selectedvenue = v;
    notifyListeners();
  }

  void newchannel(String channel) {
    selectedchannel = channel;
    notifyListeners();
  }

  void newvenueid(int v) {
    venueid = v;
    notifyListeners();
  }

  void channellist(List<String> channel) {
    _lstchannel = channel;
    notifyListeners();
  }

  void venuelist(List<Venue> venue) {
    _lstvenue = venue;
    notifyListeners();
  }

  void channelEmpty() {
    _lstchannel = [];
  }

  void venueEmpty() {
    _lstvenue = [];
  }

  void venueincrement(Venue venue) {
    _lstvenue.add(venue);
    notifyListeners();
  }

  void venueidlist(List<int> venue) {
    _lstvenueid = venue;
    notifyListeners();
  }

  void venueidlistEmpty() {
    _lstvenueid = [];
  }
}
