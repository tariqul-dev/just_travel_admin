class DistrictsModel {
  DistrictsModel({
    this.id,
    this.district,
    this.coordinates,
    this.upazilla,
  });


  @override
  String toString() {
    return 'DistrictsModel{id: $id, district: $district, coordinates: $coordinates, upazilla: $upazilla}';
  }

  DistrictsModel.fromJson(dynamic json) {
    id = json['_id'];
    district = json['district'];
    coordinates = json['coordinates'];
    upazilla = json['upazilla'] != null ? json['upazilla'].cast<String>() : [];
  }
  String? id;
  String? district;
  String? coordinates;
  List<String>? upazilla;
  DistrictsModel copyWith({
    String? id,
    String? district,
    String? coordinates,
    List<String>? upazilla,
  }) =>
      DistrictsModel(
        id: id ?? this.id,
        district: district ?? this.district,
        coordinates: coordinates ?? this.coordinates,
        upazilla: upazilla ?? this.upazilla,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['district'] = district;
    map['coordinates'] = coordinates;
    map['upazilla'] = upazilla;
    return map;
  }
}
