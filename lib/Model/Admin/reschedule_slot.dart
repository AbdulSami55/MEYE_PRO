class RescheduleSlot {
  int? id;
  String? discipline;

  RescheduleSlot({
    this.id,
    this.discipline,
  });
  RescheduleSlot.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    discipline = json['discipline']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['discipline'] = discipline;
    return data;
  }
}
