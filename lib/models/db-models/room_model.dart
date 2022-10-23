class RoomModel {
  RoomModel({
      this.title, 
      this.status, 
      this.maxCapacity, 
      this.photos, 
      this.description, 
      this.price, 
      this.roomNumber, 
      this.checkIn, 
      this.checkOut, 
      this.hotel, 
      this.users, 
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  RoomModel.fromJson(dynamic json) {
    title = json['title'];
    status = json['status'];
    maxCapacity = json['maxCapacity'];
    photos = json['photos'] != null ? json['photos'].cast<String>() : [];
    description = json['description'];
    price = json['price'];
    roomNumber = json['roomNumber'];
    checkIn = json['checkIn'];
    checkOut = json['checkOut'];
    hotel = json['hotel'];
    users = json['users'] != null ? json['users'].cast<String>() : [];
    id = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? title;
  String? status;
  num? maxCapacity;
  List<String>? photos;
  String? description;
  num? price;
  String? roomNumber;
  num? checkIn;
  num? checkOut;
  String? hotel;
  List<String>? users;
  String? id;
  String? createdAt;
  String? updatedAt;
  num? v;
RoomModel copyWith({  String? title,
  String? status,
  num? maxCapacity,
  List<String>? photos,
  String? description,
  num? price,
  String? roomNumber,
  num? checkIn,
  num? checkOut,
  String? hotel,
  List<String>? users,
  String? id,
  String? createdAt,
  String? updatedAt,
  num? v,
}) => RoomModel(  title: title ?? this.title,
  status: status ?? this.status,
  maxCapacity: maxCapacity ?? this.maxCapacity,
  photos: photos ?? this.photos,
  description: description ?? this.description,
  price: price ?? this.price,
  roomNumber: roomNumber ?? this.roomNumber,
  checkIn: checkIn ?? this.checkIn,
  checkOut: checkOut ?? this.checkOut,
  hotel: hotel ?? this.hotel,
  users: users ?? this.users,
  id: id ?? this.id,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
  v: v ?? this.v,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['status'] = status;
    map['maxCapacity'] = maxCapacity;
    map['photos'] = photos;
    map['description'] = description;
    map['price'] = price;
    map['roomNumber'] = roomNumber;
    map['checkIn'] = checkIn;
    map['checkOut'] = checkOut;
    map['hotel'] = hotel;
    map['users'] = users;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}