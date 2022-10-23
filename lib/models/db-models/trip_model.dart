class TripModel {
  TripModel({
      this.placeName, 
      this.description, 
      this.city, 
      this.division, 
      this.startDate, 
      this.endDate, 
      this.photos, 
      this.capacity, 
      this.joinedPersons, 
      this.status, 
      this.cost, 
      this.users, 
      this.hotel, 
      this.rooms, 
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  TripModel.fromJson(dynamic json) {
    placeName = json['placeName'];
    description = json['description'];
    city = json['city'];
    division = json['division'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    photos = json['photos'] != null ? json['photos'].cast<String>() : [];
    capacity = json['capacity'];
    joinedPersons = json['joinedPersons'];
    status = json['status'];
    cost = json['cost'];
    users = json['users'] != null ? json['users'].cast<String>() : [];
    hotel = json['hotel'];
    rooms = json['rooms'] != null ? json['rooms'].cast<String>() : [];
    id = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? placeName;
  String? description;
  String? city;
  String? division;
  num? startDate;
  num? endDate;
  List<String>? photos;
  num? capacity;
  num? joinedPersons;
  String? status;
  num? cost;
  List<String>? users;
  String? hotel;
  List<String>? rooms;
  String? id;
  String? createdAt;
  String? updatedAt;
  num? v;
TripModel copyWith({  String? placeName,
  String? description,
  String? city,
  String? division,
  num? startDate,
  num? endDate,
  List<String>? photos,
  num? capacity,
  num? joinedPersons,
  String? status,
  num? cost,
  List<String>? users,
  String? hotel,
  List<String>? rooms,
  String? id,
  String? createdAt,
  String? updatedAt,
  num? v,
}) => TripModel(  placeName: placeName ?? this.placeName,
  description: description ?? this.description,
  city: city ?? this.city,
  division: division ?? this.division,
  startDate: startDate ?? this.startDate,
  endDate: endDate ?? this.endDate,
  photos: photos ?? this.photos,
  capacity: capacity ?? this.capacity,
  joinedPersons: joinedPersons ?? this.joinedPersons,
  status: status ?? this.status,
  cost: cost ?? this.cost,
  users: users ?? this.users,
  hotel: hotel ?? this.hotel,
  rooms: rooms ?? this.rooms,
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
    map['startDate'] = startDate;
    map['endDate'] = endDate;
    map['photos'] = photos;
    map['capacity'] = capacity;
    map['joinedPersons'] = joinedPersons;
    map['status'] = status;
    map['cost'] = cost;
    map['users'] = users;
    map['hotel'] = hotel;
    map['rooms'] = rooms;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}