class TeacherSchedule {
  String tid = '';
  String displine = 'BCS';
  String sem = '1';
  String sec = 'A';
  String starttime = '8:30';
  String endtime = '10:00';
  bool fmin = false;
  bool lmin = false;
  bool full = false;
  String coursename = '';
  String day = 'Monday';
  String room = '';

  TeacherSchedule(
      {required this.tid,
      required this.displine,
      required this.sec,
      required this.sem,
      required this.starttime,
      required this.endtime,
      required this.fmin,
      required this.lmin,
      required this.full,
      required this.coursename,
      required this.day,
      required this.room});

  factory TeacherSchedule.fromjson(Map<String, dynamic> json) {
    return TeacherSchedule(
        tid: json["id"],
        displine: json['disp'],
        sec: json['sec'],
        sem: json['sem'],
        starttime: json['starttime'],
        endtime: json['endtime'],
        fmin: json['sr'],
        lmin: json['er'],
        full: json['ar'],
        coursename: json['coursename'],
        day: json['day'],
        room: json['room']);
  }
}
