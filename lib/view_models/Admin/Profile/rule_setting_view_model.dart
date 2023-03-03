import 'package:flutter/cupertino.dart';

class RuleSettingViewModel with ChangeNotifier {
  bool _first = false;
  bool _last = false;
  bool _full = false;

  bool get first => _first;
  bool get last => _last;
  bool get full => _full;

  setFirst(bool val) {
    _first = val;
    notifyListeners();
  }

  setLast(bool val) {
    _last = val;
    notifyListeners();
  }

  setFull(bool val) {
    _full = val;
    notifyListeners();
  }
}
