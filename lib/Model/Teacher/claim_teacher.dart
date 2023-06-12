import 'dart:convert';

class ClaimTeacher {
  String? file;
  String? thumbnail;
  String? folder;

  ClaimTeacher(
      {required this.file, required this.thumbnail, required this.folder});

  ClaimTeacher.fromJson(Map<String, dynamic> json) {
    file = json['file'];
    thumbnail = json['thumbnail'];
    folder = json['folder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['file'] = file;
    data['thumbnail'] = thumbnail;
    data['folder'] = folder;
    return data;
  }
}

List<ClaimTeacher> claimTeacherFromJson(String str) => List<ClaimTeacher>.from(
    json.decode(str).map((x) => ClaimTeacher.fromJson(x)));
