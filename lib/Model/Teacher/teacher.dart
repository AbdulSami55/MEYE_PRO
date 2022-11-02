// ignore_for_file: file_names

class TeacherData {
  String? tNAME;
  String? tID;
  String? tPASS;
  String? tIMAGE;

  TeacherData({this.tID, this.tIMAGE, this.tNAME, this.tPASS});

  factory TeacherData.fromjson(Map<String, dynamic> json) {
    return TeacherData(
        tID: json['id'],
        tNAME: json['name'],
        tPASS: json['password'],
        tIMAGE: json['image']);
  }
}
