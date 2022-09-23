class TripModel {
  TripModel({
    this.id,
    this.placeName,
    this.description,
    this.city,
    this.division,
    this.schedule,
    this.days,
    this.photos,
    this.capacity,
    this.cost,
    this.users,
    this.hotel,
    this.rooms,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.status,
  });

  @override
  String toString() {
    return 'TripModel{id: $id, placeName: $placeName, description: $description, city: $city, division: $division, schedule: $schedule, days: $days, photos: $photos, capacity: $capacity, cost: $cost, users: $users, hotel: $hotel, rooms: $rooms, createdAt: $createdAt, updatedAt: $updatedAt, v: $v, status: $status}';
  }

  TripModel.fromJson(dynamic json) {
    id = json['_id'];
    placeName = json['placeName'];
    description = json['description'];
    city = json['city'];
    division = json['division'];
    schedule = json['schedule'];
    days = json['days'];
    photos = json['photos'] != null ? json['photos'].cast<String>() : [];
    capacity = json['capacity'];
    cost = json['cost'];
    users = json['users'] != null ? json['users'].cast<String>() : [];
    hotel = json['hotel'];
    rooms = json['rooms'] != null ? json['rooms'].cast<String>() : [];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
    status = json['status'];
  }
  String? id;
  String? placeName;
  String? description;
  String? city;
  String? division;
  num? schedule;
  num? days;
  List<String>? photos;
  num? capacity;
  num? cost;
  List<String>? users;
  String? hotel;
  List<String>? rooms;
  String? createdAt;
  String? updatedAt;
  num? v;
  String? status;
  TripModel copyWith({
    String? id,
    String? placeName,
    String? description,
    String? city,
    String? division,
    num? schedule,
    num? days,
    List<String>? photos,
    num? capacity,
    num? cost,
    List<String>? users,
    String? hotel,
    List<String>? rooms,
    String? createdAt,
    String? updatedAt,
    num? v,
    String? status,
  }) =>
      TripModel(
        id: id ?? this.id,
        placeName: placeName ?? this.placeName,
        description: description ?? this.description,
        city: city ?? this.city,
        division: division ?? this.division,
        schedule: schedule ?? this.schedule,
        days: days ?? this.days,
        photos: photos ?? this.photos,
        capacity: capacity ?? this.capacity,
        cost: cost ?? this.cost,
        users: users ?? this.users,
        hotel: hotel ?? this.hotel,
        rooms: rooms ?? this.rooms,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
        status: status ?? this.status,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    // map['_id'] = id;
    map['placeName'] = placeName;
    map['description'] = description;
    map['city'] = city;
    map['division'] = division;
    map['schedule'] = schedule;
    map['days'] = days;
    map['photos'] = photos;
    map['capacity'] = capacity;
    map['cost'] = cost;
    map['users'] = users;
    map['hotel'] = hotel;
    map['rooms'] = rooms;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    map['status'] = status;
    return map;
  }
}
