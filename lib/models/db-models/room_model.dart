class RoomModel {
  RoomModel({
    this.id,
    this.title,
    this.status,
    this.maxCapacity,
    this.photos,
    this.description,
    this.price,
    this.roomNumber,
    this.unavailableDates,
    this.hotel,
    this.users,
    this.v,
    this.createdAt,
    this.updatedAt,
  });

  @override
  String toString() {
    return 'RoomModel{id: $id, title: $title, status: $status, maxCapacity: $maxCapacity, photos: $photos, description: $description, price: $price, roomNumber: $roomNumber, unavailableDates: $unavailableDates, hotel: $hotel, users: $users, v: $v, createdAt: $createdAt, updatedAt: $updatedAt}';
  }

  RoomModel.fromJson(dynamic json) {
    id = json['_id'];
    title = json['title'];
    status = json['status'];
    maxCapacity = json['maxCapacity'];
    photos = json['photos'] != null ? json['photos'].cast<String>() : [];
    description = json['description'];
    price = json['price'];
    roomNumber = json['roomNumber'];
    unavailableDates = json['unavailableDates'] != null
        ? json['unavailableDates'].cast<num>()
        : [];
    hotel = json['hotel'];
    users = json['users'] != null ? json['users'].cast<String>() : [];
    v = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
  String? id;
  String? title;
  String? status;
  num? maxCapacity;
  List<String>? photos;
  String? description;
  num? price;
  String? roomNumber;
  List<num>? unavailableDates;
  String? hotel;
  List<String>? users;
  num? v;
  String? createdAt;
  String? updatedAt;
  RoomModel copyWith({
    String? id,
    String? title,
    String? status,
    num? maxCapacity,
    List<String>? photos,
    String? description,
    num? price,
    String? roomNumber,
    List<num>? unavailableDates,
    String? hotel,
    List<String>? users,
    num? v,
    String? createdAt,
    String? updatedAt,
  }) =>
      RoomModel(
        id: id ?? this.id,
        title: title ?? this.title,
        status: status ?? this.status,
        maxCapacity: maxCapacity ?? this.maxCapacity,
        photos: photos ?? this.photos,
        description: description ?? this.description,
        price: price ?? this.price,
        roomNumber: roomNumber ?? this.roomNumber,
        unavailableDates: unavailableDates ?? this.unavailableDates,
        hotel: hotel ?? this.hotel,
        users: users ?? this.users,
        v: v ?? this.v,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    // map['_id'] = id;
    map['title'] = title;
    map['status'] = status;
    map['maxCapacity'] = maxCapacity;
    map['photos'] = photos;
    map['description'] = description;
    map['price'] = price;
    map['roomNumber'] = roomNumber;
    map['unavailableDates'] = unavailableDates;
    map['hotel'] = hotel;
    map['users'] = users;
    map['__v'] = v;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }
}
