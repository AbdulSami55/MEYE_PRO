// ignore_for_file: prefer_final_fields, prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
import 'package:live_streaming/Model/Admin/recordings.dart';
import 'package:live_streaming/Model/user_error.dart';
import 'package:live_streaming/repo/Admin/teacher_recording_services.dart';
import 'package:live_streaming/repo/api_status.dart';
import 'package:video_player/video_player.dart';

class TeacherRecordingsViewModel with ChangeNotifier {
  bool _isloading = false;
  var _teacherrecordings;
  UserError? _userError;
  String filter = "Section";
  List<Recordings> tempTeacherRecordings = [];
  var _videoController;
  Future<void>? _initializeVideoPlayerFuture;
  var _selectedVideo;
  bool isshow = false;

  bool get loading => _isloading;
  UserError? get userError => _userError;
  List<Recordings> get teacherrecordings => _teacherrecordings;
  VideoPlayerController get videoController => _videoController;

  Recordings get selectedVideo => _selectedVideo;

  TeacherRecordingsViewModel(String teacherName, {bool? isRecording}) {
    if (isRecording == null) {
      getData(teacherName);
    } else {
      getRecordingsData();
    }
  }
  setloading(bool loading) {
    _isloading = loading;
    notifyListeners();
  }

  setSelectedVideo(Recordings recordings) {
    _selectedVideo = recordings;

    notifyListeners();
  }

  // getVideoPosition() {
  //   var duration = Duration(
  //       milliseconds: videoController.value.position.inMilliseconds.round());
  //   time = [duration.inMinutes, duration.inSeconds]
  //       .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
  //       .join(':');
  // }

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

  void setFilter(String value) {
    if (value != "") {
      if (filter == "Date") {
        tempTeacherRecordings = teacherrecordings
            .where((element) => element.date.toString().contains(value))
            .toList();
      } else if (filter == "Type") {
        tempTeacherRecordings = teacherrecordings
            .where((element) => element.fileName.toString().contains(value))
            .toList();
      } else if (filter == "Section") {
        tempTeacherRecordings = teacherrecordings
            .where((element) => element.discipline.toString().contains(value))
            .toList();
      } else if (filter == "Course") {
        tempTeacherRecordings = teacherrecordings
            .where((element) => element.courseName.toString().contains(value))
            .toList();
      }
    } else {
      tempTeacherRecordings = teacherrecordings;
    }
    notifyListeners();
  }

  void setTeacherRecordings(List<Recordings> lst) {
    tempTeacherRecordings = lst;
    _teacherrecordings = lst;
  }

  void setUserError(UserError userError) {
    _userError = userError;
  }

  getData(String teacherName) async {
    setloading(true);
    var response = await TeacherRecordingServies.getRecordings(teacherName);
    if (response is Success) {
      setTeacherRecordings(response.response as List<Recordings>);
    }
    if (response is Failure) {
      UserError userError =
          UserError(code: response.code, message: response.errorResponse);
      setUserError(userError);
    }
    setloading(false);
  }

  getRecordingsData() async {
    setloading(true);
    var response = await TeacherRecordingServies.getAllRecordings();
    if (response is Success) {
      setTeacherRecordings(response.response as List<Recordings>);
    }
    if (response is Failure) {
      UserError userError =
          UserError(code: response.code, message: response.errorResponse);
      setUserError(userError);
    }
    setloading(false);
  }
}
