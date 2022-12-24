// ignore_for_file: file_names

class Venue {
  final int id;
  final String name;

  Venue(
      {required this.id,
      required this.name});

  factory Venue.fromjson(Map<String, dynamic> json) {
    return Venue(
        id: json["id"],
        name: json["name"],
    );
  }

  Map tomap() {
    Map m = {};
    m['id'] = id;
    m['name'] = name;
    return m;
  }
}
