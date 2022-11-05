class DivisionsModel {
  DivisionsModel({
    this.id,
    this.division,
    this.divisionbn,
    this.coordinates,
  });

  DivisionsModel.fromJson(dynamic json) {
    id = json['_id'];
    division = json['division'];
    divisionbn = json['divisionbn'];
    coordinates = json['coordinates'];
  }
  String? id;
  String? division;
  String? divisionbn;
  String? coordinates;
  DivisionsModel copyWith({
    String? id,
    String? division,
    String? divisionbn,
    String? coordinates,
  }) =>
      DivisionsModel(
        id: id ?? this.id,
        division: division ?? this.division,
        divisionbn: divisionbn ?? this.divisionbn,
        coordinates: coordinates ?? this.coordinates,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['division'] = division;
    map['divisionbn'] = divisionbn;
    map['coordinates'] = coordinates;
    return map;
  }
}
