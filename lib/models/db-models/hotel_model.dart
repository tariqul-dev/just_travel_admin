class HotelModel {
  HotelModel({
    this.id,
    this.name,
    this.type,
    this.city,
    this.division,
    this.photos,
    this.description,
    this.rating,
    this.rooms,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  @override
  String toString() {
    return 'HotelModel{id: $id, name: $name, type: $type, city: $city, division: $division, photos: $photos, description: $description, rating: $rating, rooms: $rooms, createdAt: $createdAt, updatedAt: $updatedAt, v: $v}';
  }

  HotelModel.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    type = json['type'];
    city = json['city'];
    division = json['division'];
    photos = json['photos'] != null ? json['photos'].cast<String>() : [];
    description = json['description'];
    rating = json['rating'];
    rooms = json['rooms'] != null ? json['rooms'].cast<String>() : [];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? id;
  String? name;
  String? type;
  String? city;
  String? division;
  List<String>? photos;
  String? description;
  num? rating;
  List<String>? rooms;
  String? createdAt;
  String? updatedAt;
  num? v;
  HotelModel copyWith({
    String? id,
    String? name,
    String? type,
    String? city,
    String? division,
    List<String>? photos,
    String? description,
    num? rating,
    List<String>? rooms,
    String? createdAt,
    String? updatedAt,
    num? v,
  }) =>
      HotelModel(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        city: city ?? this.city,
        division: division ?? this.division,
        photos: photos ?? this.photos,
        description: description ?? this.description,
        rating: rating ?? this.rating,
        rooms: rooms ?? this.rooms,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['type'] = type;
    map['city'] = city;
    map['division'] = division;
    map['photos'] = photos;
    map['description'] = description;
    map['rating'] = rating;
    map['rooms'] = rooms;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }
}
