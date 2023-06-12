// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

const Color backgroundColor2 = Color(0xFF17203A);
const Color backgroundColorLight = Color(0xFFF2F6FF);
const Color backgroundColorDark = Color(0xFF25254B);
const Color shadowColorLight = Color(0xFF4A5367);
const Color shadowColorDark = Colors.black;
const Color primaryColor = Colors.green;
Color? backgroundColor = Colors.grey[300];
const Color containerColor = Colors.white;
const Color containerCardColor = Color(0xFF7553F6);
const Color teacherCardColor1 = Color(0xFF80A4FF);
const Color teacherCardColor2 = Color(0xFF9CC5FF);
//------------------------Font Size---------------------------
const MediumFontSize = 25;
//-------------------------Errors------------------------------
const INVALID_RESPONSE = 100;
const NO_INTERNET = 101;
const INVALID_FORMAT = 102;
const UNKNOWN_ERROR = 103;
//------------------------------------URLS---------------------

const String baseUrl = 'http://192.168.0.105:8000';
const String addadvrurl = '$baseUrl/api/add-dvr';
const String getdvrurl = '$baseUrl/api/dvr-details';
const String addcameraurl = '$baseUrl/api/add-camera';
const String getcameraurl = '$baseUrl/api/camera-details/';
const String getvenueurl = '$baseUrl/api/venue-details';
const String adduserurl = '$baseUrl/api/add-user';
const String addstudenturl = '$baseUrl/api/add-student';
const String getuserurl = '$baseUrl/api/user-details';
const String getsigninurl = '$baseUrl/api/signin';
const String getstudenturl = '$baseUrl/api/student-details';
const String getStudentOfferedCourseurl =
    '$baseUrl/api/student-offered-courses';
const String getuserimage = '$baseUrl/api/get-user-image/UserImages/';
const String getstudentimage =
    '$baseUrl/api/get-student-image/UserImages/Student/';
const String gettimetableurl = '$baseUrl/api/timetable-details/';
const String getteachertimetableurl = '$baseUrl/api/teacher-timetable-details/';
const String getteacherrulestimetableurl = '$baseUrl/api/get-rules-timetable/';
const String getteachurl = '$baseUrl/api/teach-details/';
const String gettimetable = '$baseUrl/api/timetable-details';
const String getTimeTableByDateurl = '$baseUrl/api/timetable-details-by-date';
const String addreschedule = '$baseUrl/api/add-reschedule';
const String addpreschedule = '$baseUrl/api/add-preschedule';
const String getcheckTeacherRescheduleClassurl =
    '$baseUrl/api/check-teacher-reschedule';
const String getteacherrecordings =
    '$baseUrl/api/recordings-details-by-teachername/';
const String getvideo = '$baseUrl/video?path=';
const String getSectionOfferCoursesurl = '$baseUrl/api/section-offer-details';
const String enrollStudenturl = '$baseUrl/api/student-enroll';
const String getCourseurl = '$baseUrl/api/get-student-courses';
const String markAttendanceurl = '$baseUrl/api/mark-attendance';
const String addAttendanceurl = '$baseUrl/api/add-attendance';
const String getCourseAttendanceurl = '$baseUrl/api/get-course-attendance';
const String getTeacherCHRurl = '$baseUrl/api/get-teacher-chr';
const String getAllTeacherCHRurl = '$baseUrl/api/get-all-teacher-chr';
const String addRulesurl = '$baseUrl/api/add-rules';
const String getSwappingUserDataurl = '$baseUrl/api/get-swapping-teacher-data';
const String addswappingurl = '$baseUrl/api/add-swapping';
const String getallrecordingsurl = '$baseUrl/api/recordings-details';
const String getAllDemoVideourl = '$baseUrl/api/demo';
const String getDemoVideDetailsurl = '$baseUrl/api/demovideos?file=';
const String getAttendanceNotificationurl =
    '$baseUrl/api/get-attendance-notification';
const String getTeacherClaimurl = '$baseUrl/api/teacher-claim';
const String getClaimVideoThumbnialurl =
    '$baseUrl/api/claim-video-thumbnails?file=';
const String getClaimVideourl = '$baseUrl/api/get-claim-video?file=';
const String getStudentNotificationurl =
    '$baseUrl/api/get-student-notification-data';
//----------------------------------------------------Routes-----------------------------------

const String routesStudentDashboard = '/StudentDashboard';
const String routesSignin = '/';
const String routesTeacherDashboard = '/TeacherDashboard';
const String routesTeacherBottomNavBar = '/TeacherBottomNavBar';
const String routesAdminBottomNavBar = '/AdminHome';
const String routesAttendanceCamera = '/AttendanceCamera';
const String routesProfile = '/Profile';
const String routesLiveStreamDetails = '/LiveStreamDetails';
const String routesAssignCourse = '/AssignCourse';
const String routesRuleSetting = '/RuleSetting';
const String routesTeacherDetails = 'TeacherDetails';
const String routesStudentCourseOffered = 'StudentCourseOffered';
const String routesCourseAttendance = '/CourseAttendance';
const String routesTeacherChr = '/TeacherChr';
const String routesTeacherChrDetailsScreen = '/TeacherChrDetailsScreen';
const String routesFreeSlotView = 'FreeSlotView';
const String routesDirectorDashboard = '/DirectorDashboard';
const String routesTeacherChrDetails = '/TeacherChrDetails';
const String routesDemo = '/Demo';
