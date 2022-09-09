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
    if (json['rooms'] != null) {
      rooms = [];
      json['rooms'].forEach((v) {
        rooms?.add(Rooms.fromJson(v));
      });
    }
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
  dynamic rating;
  List<Rooms>? rooms;
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
    dynamic rating,
    List<Rooms>? rooms,
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
    map['_id'] = id;
    map['name'] = name;
    map['type'] = type;
    map['city'] = city;
    map['division'] = division;
    map['photos'] = photos;
    map['description'] = description;
    map['rating'] = rating;
    if (rooms != null) {
      map['rooms'] = rooms?.map((v) => v.toJson()).toList();
    }
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }
}

class Rooms {
  Rooms({
    this.title,
    this.status,
    this.maxCapacity,
    this.photos,
    this.description,
    this.price,
    this.unavailableDates,
    this.id,
    this.roomNumber,

  });


  @override
  String toString() {
    return 'Rooms{title: $title, status: $status, maxCapacity: $maxCapacity, photos: $photos, description: $description, price: $price, unavailableDates: $unavailableDates, id: $id}';
  }

  Rooms.fromJson(dynamic json) {
    title = json['title'];
    status = json['status'];
    maxCapacity = json['maxCapacity'];
    photos = json['photos'] != null ? json['photos'].cast<String>() : [];
    description = json['description'];
    price = json['price'];
    roomNumber = json['roomNumber'];
    unavailableDates = json['unavailableDates'];
    id = json['_id'];
  }
  String? title;
  String? status;
  num? maxCapacity;
  List<String>? photos;
  String? description;
  num? price;
  num? unavailableDates;
  String? roomNumber;
  String? id;

  Rooms copyWith({
    String? title,
    String? status,
    num? maxCapacity,
    List<String>? photos,
    String? description,
    num? price,
    num? unavailableDates,
    String? id,
  }) =>
      Rooms(
        title: title ?? this.title,
        status: status ?? this.status,
        maxCapacity: maxCapacity ?? this.maxCapacity,
        photos: photos ?? this.photos,
        description: description ?? this.description,
        price: price ?? this.price,
        roomNumber: roomNumber ?? roomNumber,
        unavailableDates: unavailableDates ?? this.unavailableDates,
        id: id ?? this.id,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['status'] = status;
    map['maxCapacity'] = maxCapacity;
    map['photos'] = photos;
    map['description'] = description;
    map['price'] = price;
    map['unavailableDates'] = unavailableDates;
    return map;
  }
}
