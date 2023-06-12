// ignore_for_file: prefer_final_fields, prefer_typing_uninitialized_variables
import 'package:flutter/cupertino.dart';
import 'package:live_streaming/Model/Teacher/claim_teacher.dart';
import 'package:live_streaming/Model/Teacher/teacher_chr.dart';
import 'package:live_streaming/Model/user_error.dart';
import 'package:live_streaming/repo/Teacher/teacher_chr.dart';
import 'package:live_streaming/repo/api_status.dart';
import 'package:screenshot/screenshot.dart';
import 'package:video_player/video_player.dart';

class TeacherCHRViewModel with ChangeNotifier {
  var _lstTeacherChr = <TeacherChr>[];
  var _lstTempTeacherChr = <TeacherChr>[];
  bool _isloading = false;
  UserError? _userError;
  int selectedIndex = -1;
  int selectedTab = 0;
  bool isChr = true;
  bool isTeacherChr = true;
  bool isChrTable = false;
  bool isActivtyTable = false;
  String isTeacherTableSwitch = "";
  var _lstClaim = <ClaimTeacher>[];
  var _videoController;
  var _selectedVideo;
  List<ClaimTeacher> tempTeacherClaimVideo = [];
  Future<void>? _initializeVideoPlayerFuture;
  bool isshow = false;

  int selectedFilter = 0;
  ScreenshotController _screenshotController = ScreenshotController();
  VideoPlayerController get videoController => _videoController;
  List<TeacherChr> get lstTeacherChr => _lstTeacherChr;
  List<TeacherChr> get lstTempTeacherChr => _lstTempTeacherChr;
  bool get isloading => _isloading;
  UserError? get userError => _userError;
  ScreenshotController get screenshotController => _screenshotController;
  List<ClaimTeacher> get lstClaim => _lstClaim;
  ClaimTeacher get selectedVideo => _selectedVideo;

  TeacherCHRViewModel(String teacherName, {bool? isDirector}) {
    if (isDirector == null) {
      getTeacherCHR(teacherName);
    } else {
      getAllTeacherCHR();
    }
  }

  setLstClaim(List<ClaimTeacher> lst) {
    tempTeacherClaimVideo = lst;
    _lstClaim = lst;
  }

  setSelectedVideo(ClaimTeacher recordings) {
    _selectedVideo = recordings;

    notifyListeners();
  }

  setPlayer(String path) async {
    setloading(true);
    if (_videoController != null) {
      _videoController.dispose();
    }

    _videoController = VideoPlayerController.network(path);
    _initializeVideoPlayerFuture = videoController.initialize();
    _initializeVideoPlayerFuture?.then((value) => setloading(false));
    _videoController.play();
  }

  setIsShow() {
    isshow = !isshow;
    notifyListeners();
  }

  setListTeacherChr(List<TeacherChr> lst) {
    _lstTeacherChr = lst;
    _lstTempTeacherChr = lst;
  }

  void searchChr(String value) {
    if (value.length > 1) {
      if (selectedFilter == 1) {
        _lstTempTeacherChr = _lstTeacherChr
            .where((element) => element.date
                .toString()
                .toLowerCase()
                .contains(value.toLowerCase()))
            .toList();
      } else if (selectedFilter == 2) {
        _lstTempTeacherChr = _lstTeacherChr
            .where((element) => element.courseName
                .toString()
                .toLowerCase()
                .contains(value.toLowerCase()))
            .toList();
      } else if (selectedFilter == 3) {
        _lstTempTeacherChr = _lstTeacherChr
            .where((element) => element.discipline
                .toString()
                .toLowerCase()
                .contains(value.toLowerCase()))
            .toList();
      } else if (selectedFilter == 4) {
        _lstTempTeacherChr = _lstTeacherChr
            .where((element) => element.teacherName
                .toString()
                .toLowerCase()
                .contains(value.toLowerCase()))
            .toList();
      }
    } else {
      _lstTempTeacherChr = _lstTeacherChr;
    }
    notifyListeners();
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

  getTeacherClaimVideo(int teacherSlotId) async {
    setloading(true);
    _lstClaim = [];
    _userError = null;
    var response = await TeacherCHRServies.getTeacherClaim(teacherSlotId);
    if (response is Success) {
      setLstClaim(response.response as List<ClaimTeacher>);
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
