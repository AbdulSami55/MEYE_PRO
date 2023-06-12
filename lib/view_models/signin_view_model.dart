// ignore_for_file: unused_field, prefer_final_fields

import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:live_streaming/Model/Admin/user.dart';
import 'package:live_streaming/repo/Admin/user_service.dart';
import 'package:live_streaming/repo/Student/student_course_service.dart';
import 'package:live_streaming/repo/api_status.dart';
// import 'package:ml_linalg/linalg.dart';

import '../../../Model/user_error.dart';

class SignInViewModel extends ChangeNotifier {
  bool _isloading = false;
  UserError? _userError;
  User? _user;
  int previousId = -1;
  bool isTimer = true;

  bool get isloading => _isloading;
  UserError? get userError => _userError;
  User get user => _user!;

  void setloading(bool load) {
    _isloading = load;
    notifyListeners();
  }

  void setUserError(UserError userError) {
    _userError = userError;
  }

  void setUser(User user) {
    _user = user;
  }

  Future signin(String userId, String password) async {
    _userError = null;
    _user = null;
    var response = await UserServies.SignIn(userId, password);
    if (response is Success) {
      var data = json.decode(response.response as String);
      if (data != "Invalid Password" && data != "User Not Found") {
        User user = User.fromJson(data);
        setUser(user);
        return "move";
      } else {
        UserError userError = UserError(code: response.code, message: data);
        setUserError(userError);
      }
    }
    if (response is Failure) {
      UserError userError =
          UserError(code: response.code, message: response.errorResponse);
      setUserError(userError);
    }
    return "done";
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Timer? timer;

  void startAPIRequests() {
    timer?.cancel();

    if (user.role == 'Student') {
      timer = Timer.periodic(const Duration(seconds: 3), (_) async {
        await hitAPI();
      });
    }
  }

  Future<void> hitAPI() async {
    var response =
        await StudentCourseServies.getAttendanceNotification(user.userID!);
    if (response is Success) {
      int res = response.response as int;
      if (res != -1 && previousId != res) {
        previousId = res;
        showNotification();
      }
    }
  }

  Future<void> showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('your_channel_id', 'your_channel_name',
            importance: Importance.max, priority: Priority.high);

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
        0, 'Attendance Alert', 'You are absent', platformChannelSpecifics,
        payload: "Attendance");
  }

  void stopAPIRequests() {
    timer?.cancel();
    timer = null;
  }
}
