class Rules {
  int id;
  int timeTableId;
  int startRecord;
  int midRecord;
  int endRecord;
  int fullRecord;

  Rules(
      {required this.id,
      required this.timeTableId,
      required this.startRecord,
      required this.midRecord,
      required this.endRecord,
      required this.fullRecord});

  factory Rules.fromJson(Map<String, dynamic> json) {
    return Rules(
      id: json['id'],
      timeTableId: json['timeTableId'],
      startRecord: json['startRecord'],
      midRecord: json['midRecord'],
      endRecord: json['endRecord'],
      fullRecord: json['fullRecord'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['timeTableId'] = timeTableId;
    data['startRecord'] = startRecord;
    data['midRecord'] = midRecord;
    data['endRecord'] = endRecord;
    data['fullRecord'] = fullRecord;
    return data;
  }
}
