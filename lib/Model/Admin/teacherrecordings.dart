import 'dart:convert';

import 'package:live_streaming/Model/Admin/course.dart';
import 'package:live_streaming/Model/Admin/recordings.dart';
import 'package:live_streaming/Model/Admin/section.dart';
import 'package:live_streaming/Model/Admin/teacherslot.dart';
import 'package:live_streaming/Model/Admin/timetable.dart';
import 'package:live_streaming/Model/Admin/venue.dart';

List<TeacherRecordings> lstteacherrecordingsFromJson(String str) =>
    List<TeacherRecordings>.from(
        json.decode(str).map((x) => TeacherRecordings.fromJson(x)));

TeacherRecordings teacherrecordingsFromJson(String str) =>
    TeacherRecordings.fromJson(json.decode(str));

class TeacherRecordings {
  TeacherRecordings(
      {required this.teacherslot,
      required this.recordings,
      required this.timetable,
      required this.section,
      required this.venue,
      required this.course});
  List<TeacherSlot> teacherslot;
  List<Recordings> recordings;
  List<TimeTable> timetable;
  List<Section> section;
  List<Venue> venue;
  List<Course> course;

  factory TeacherRecordings.fromJson(Map<String, dynamic> json) =>
      TeacherRecordings(
          teacherslot: rlistteacherSlotFromJson(json["teacherslot"]),
          recordings: rlistrecordingsFromJson(json["recordings"]),
          timetable: rlsttimetableFromJson(json["timetable"]),
          section: rlstsectionFromJson(json["section"]),
          venue: rlstvenueFromJson(json["venue"]),
          course: rlstcourseFromJson(json["course"]));
}
