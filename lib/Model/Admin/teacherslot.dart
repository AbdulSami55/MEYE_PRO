import 'dart:convert';

TeacherSlot teacherSlotFromJson(String str) =>
    TeacherSlot.fromJson(json.decode(str));

List<TeacherSlot> listteacherSlotFromJson(String str) =>
    List<TeacherSlot>.from(json.decode(str));
String teacherSlotToJson(TeacherSlot data) => json.encode(data.toJson());

List<TeacherSlot> rlistteacherSlotFromJson(List lst) {
  List<TeacherSlot> templst = [];
  for (var i in lst) {
    templst.add(TeacherSlot.fromJson(i));
  }
  return templst;
}

class TeacherSlot {
  TeacherSlot({
    required this.id,
    required this.teachID,
    required this.slot,
    required this.status,
  });

  int id;
  int teachID;
  int slot;
  int status;

  factory TeacherSlot.fromJson(Map<String, dynamic> json) => TeacherSlot(
        id: json["id"],
        teachID: json["teachID"],
        slot: json["slot"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "teachID": teachID,
        "slot": slot,
        "status": status,
      };
}
