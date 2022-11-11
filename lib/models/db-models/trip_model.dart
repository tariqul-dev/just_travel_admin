class TripModel {
  TripModel({
      this.host, 
      this.placeName, 
      this.description, 
      this.division, 
      this.district, 
      this.startDate, 
      this.endDate, 
      this.photos, 
      this.travellers, 
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
    host = json['host'];
    placeName = json['placeName'];
    description = json['description'];
    division = json['division'];
    district = json['district'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    photos = json['photos'] != null ? json['photos'].cast<String>() : [];
    travellers = json['travellers'];
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
  String? host;
  String? placeName;
  String? description;
  String? division;
  String? district;
  num? startDate;
  num? endDate;
  List<String>? photos;
  num? travellers;
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
TripModel copyWith({  String? host,
  String? placeName,
  String? description,
  String? division,
  String? district,
  num? startDate,
  num? endDate,
  List<String>? photos,
  num? travellers,
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
}) => TripModel(  host: host ?? this.host,
  placeName: placeName ?? this.placeName,
  description: description ?? this.description,
  division: division ?? this.division,
  district: district ?? this.district,
  startDate: startDate ?? this.startDate,
  endDate: endDate ?? this.endDate,
  photos: photos ?? this.photos,
  travellers: travellers ?? this.travellers,
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
    map['host'] = host ?? 'admin';
    map['placeName'] = placeName;
    map['description'] = description;
    map['division'] = division;
    map['district'] = district;
    map['startDate'] = startDate;
    map['endDate'] = endDate;
    map['photos'] = photos;
    map['travellers'] = travellers;
    map['joinedPersons'] = joinedPersons;
    map['cost'] = cost;
    map['users'] = users;
    map['hotel'] = hotel;
    map['rooms'] = rooms;
    return map;
  }

}