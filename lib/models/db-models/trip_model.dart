class TripModel {
  TripModel({
      this.placeName, 
      this.description, 
      this.city, 
      this.division, 
      this.schedule, 
      this.days, 
      this.photos, 
      this.capacity, 
      this.cost, 
      this.hotel, 
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  TripModel.fromJson(dynamic json) {
    placeName = json['placeName'];
    description = json['description'];
    city = json['city'];
    division = json['division'];
    schedule = json['schedule'];
    days = json['days'];
    photos = json['photos'] != null ? json['photos'].cast<String>() : [];
    capacity = json['capacity'];
    cost = json['cost'];
    hotel = json['hotel'] != null ? Hotel.fromJson(json['hotel']) : null;
    id = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? placeName;
  String? description;
  String? city;
  String? division;
  String? schedule;
  num? days;
  List<String>? photos;
  num? capacity;
  num? cost;
  Hotel? hotel;
  String? id;
  String? createdAt;
  String? updatedAt;
  num? v;
TripModel copyWith({  String? placeName,
  String? description,
  String? city,
  String? division,
  String? schedule,
  num? days,
  List<String>? photos,
  num? capacity,
  num? cost,
  Hotel? hotel,
  String? id,
  String? createdAt,
  String? updatedAt,
  num? v,
}) => TripModel(  placeName: placeName ?? this.placeName,
  description: description ?? this.description,
  city: city ?? this.city,
  division: division ?? this.division,
  schedule: schedule ?? this.schedule,
  days: days ?? this.days,
  photos: photos ?? this.photos,
  capacity: capacity ?? this.capacity,
  cost: cost ?? this.cost,
  hotel: hotel ?? this.hotel,
  id: id ?? this.id,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
  v: v ?? this.v,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['placeName'] = placeName;
    map['description'] = description;
    map['city'] = city;
    map['division'] = division;
    map['schedule'] = schedule;
    map['days'] = days;
    map['photos'] = photos;
    map['capacity'] = capacity;
    map['cost'] = cost;
    if (hotel != null) {
      map['hotel'] = hotel?.toJson();
    }
    map['_id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}

class Hotel {
  Hotel({
      this.hotelId, 
      this.rooms,});

  Hotel.fromJson(dynamic json) {
    hotelId = json['hotelId'];
    if (json['rooms'] != null) {
      rooms = [];
      json['rooms'].forEach((v) {
        rooms?.add(Rooms.fromJson(v));
      });
    }
  }
  String? hotelId;
  List<Rooms>? rooms;
Hotel copyWith({  String? hotelId,
  List<Rooms>? rooms,
}) => Hotel(  hotelId: hotelId ?? this.hotelId,
  rooms: rooms ?? this.rooms,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['hotelId'] = hotelId;
    if (rooms != null) {
      map['rooms'] = rooms?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Rooms {
  Rooms({
      this.roomId, 
      this.userId, 
      this.id,});

  Rooms.fromJson(dynamic json) {
    roomId = json['roomId'];
    userId = json['userId'];
    id = json['_id'];
  }
  String? roomId;
  String? userId;
  String? id;
Rooms copyWith({  String? roomId,
  String? userId,
  String? id,
}) => Rooms(  roomId: roomId ?? this.roomId,
  userId: userId ?? this.userId,
  id: id ?? this.id,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['roomId'] = roomId;
    map['userId'] = userId;
    map['_id'] = id;
    return map;
  }

}