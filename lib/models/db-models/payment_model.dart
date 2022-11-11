class PaymentModel {
  PaymentModel({
    this.id,
    this.tripId,
    this.userId,
    this.mobileNumber,
    this.tranId,
    this.status,
    this.amount,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.joinId,
  });

  PaymentModel.fromJson(dynamic json) {
    id = json['_id'];
    tripId = json['tripId'] != null ? TripId.fromJson(json['tripId']) : null;
    userId = json['userId'] != null ? UserId.fromJson(json['userId']) : null;
    mobileNumber = json['mobileNumber'];
    tranId = json['tranId'];
    status = json['status'];
    amount = json['amount'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
    joinId = json['joinId'];
  }
  String? id;
  TripId? tripId;
  UserId? userId;
  String? mobileNumber;
  String? tranId;
  String? status;
  num? amount;
  String? createdAt;
  String? updatedAt;
  num? v;
  dynamic joinId;
  PaymentModel copyWith({
    String? id,
    TripId? tripId,
    UserId? userId,
    String? mobileNumber,
    String? tranId,
    String? status,
    num? amount,
    String? createdAt,
    String? updatedAt,
    num? v,
    dynamic joinId,
  }) =>
      PaymentModel(
        id: id ?? this.id,
        tripId: tripId ?? this.tripId,
        userId: userId ?? this.userId,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        tranId: tranId ?? this.tranId,
        status: status ?? this.status,
        amount: amount ?? this.amount,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
        joinId: joinId ?? this.joinId,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    if (tripId != null) {
      map['tripId'] = tripId?.toJson();
    }
    if (userId != null) {
      map['userId'] = userId?.toJson();
    }
    map['mobileNumber'] = mobileNumber;
    map['tranId'] = tranId;
    map['status'] = status;
    map['amount'] = amount;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    map['joinId'] = joinId;
    return map;
  }
}

class UserId {
  UserId({
    this.email,
    this.mobile,
    this.id,
    this.name,
    this.division,
    this.profileImage,
    this.coverImage,
    this.uploadImages,
    this.trips,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.district,
  });

  UserId.fromJson(dynamic json) {
    email = json['email'] != null ? Email.fromJson(json['email']) : null;
    mobile = json['mobile'] != null ? Mobile.fromJson(json['mobile']) : null;
    id = json['_id'];
    name = json['name'];
    division = json['division'];
    profileImage = json['profileImage'];
    coverImage = json['coverImage'];
    uploadImages = json['uploadImages'];
    trips = json['trips'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
    district = json['district'];
  }
  Email? email;
  Mobile? mobile;
  String? id;
  String? name;
  String? division;
  String? profileImage;
  dynamic coverImage;
  dynamic uploadImages;
  dynamic trips;
  String? createdAt;
  String? updatedAt;
  num? v;
  String? district;
  UserId copyWith({
    Email? email,
    Mobile? mobile,
    String? id,
    String? name,
    String? division,
    String? profileImage,
    dynamic coverImage,
    dynamic uploadImages,
    dynamic trips,
    String? createdAt,
    String? updatedAt,
    num? v,
    String? district,
  }) =>
      UserId(
        email: email ?? this.email,
        mobile: mobile ?? this.mobile,
        id: id ?? this.id,
        name: name ?? this.name,
        division: division ?? this.division,
        profileImage: profileImage ?? this.profileImage,
        coverImage: coverImage ?? this.coverImage,
        uploadImages: uploadImages ?? this.uploadImages,
        trips: trips ?? this.trips,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
        district: district ?? this.district,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (email != null) {
      map['email'] = email?.toJson();
    }
    if (mobile != null) {
      map['mobile'] = mobile?.toJson();
    }
    map['_id'] = id;
    map['name'] = name;
    map['division'] = division;
    map['profileImage'] = profileImage;
    map['coverImage'] = coverImage;
    map['uploadImages'] = uploadImages;
    map['trips'] = trips;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    map['district'] = district;
    return map;
  }
}

class Mobile {
  Mobile({
    this.number,
    this.isVerified,
  });

  Mobile.fromJson(dynamic json) {
    number = json['number'];
    isVerified = json['isVerified'];
  }
  String? number;
  bool? isVerified;
  Mobile copyWith({
    String? number,
    bool? isVerified,
  }) =>
      Mobile(
        number: number ?? this.number,
        isVerified: isVerified ?? this.isVerified,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['number'] = number;
    map['isVerified'] = isVerified;
    return map;
  }
}

class Email {
  Email({
    this.emailId,
    this.isVerified,
  });

  Email.fromJson(dynamic json) {
    emailId = json['emailId'];
    isVerified = json['isVerified'];
  }
  String? emailId;
  bool? isVerified;
  Email copyWith({
    String? emailId,
    bool? isVerified,
  }) =>
      Email(
        emailId: emailId ?? this.emailId,
        isVerified: isVerified ?? this.isVerified,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['emailId'] = emailId;
    map['isVerified'] = isVerified;
    return map;
  }
}

class TripId {
  TripId({
    this.id,
    this.placeName,
    this.description,
    this.division,
    this.startDate,
    this.endDate,
    this.photos,
    this.joinedPersons,
    this.status,
    this.cost,
    this.users,
    this.hotel,
    this.rooms,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.district,
    this.host,
    this.travellers,
  });

  TripId.fromJson(dynamic json) {
    id = json['_id'];
    placeName = json['placeName'];
    description = json['description'];
    division = json['division'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    photos = json['photos'] != null ? json['photos'].cast<String>() : [];
    joinedPersons = json['joinedPersons'];
    status = json['status'];
    cost = json['cost'];
    users = json['users'];
    hotel = json['hotel'];
    rooms = json['rooms'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
    district = json['district'];
    host = json['host'];
    travellers = json['travellers'];
  }
  String? id;
  String? placeName;
  String? description;
  String? division;
  num? startDate;
  num? endDate;
  List<String>? photos;
  dynamic joinedPersons;
  String? status;
  num? cost;
  dynamic users;
  String? hotel;
  dynamic rooms;
  String? createdAt;
  String? updatedAt;
  num? v;
  String? district;
  String? host;
  num? travellers;
  TripId copyWith({
    String? id,
    String? placeName,
    String? description,
    String? division,
    num? startDate,
    num? endDate,
    List<String>? photos,
    dynamic joinedPersons,
    String? status,
    num? cost,
    dynamic users,
    String? hotel,
    dynamic rooms,
    String? createdAt,
    String? updatedAt,
    num? v,
    String? district,
    String? host,
    num? travellers,
  }) =>
      TripId(
        id: id ?? this.id,
        placeName: placeName ?? this.placeName,
        description: description ?? this.description,
        division: division ?? this.division,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        photos: photos ?? this.photos,
        joinedPersons: joinedPersons ?? this.joinedPersons,
        status: status ?? this.status,
        cost: cost ?? this.cost,
        users: users ?? this.users,
        hotel: hotel ?? this.hotel,
        rooms: rooms ?? this.rooms,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
        district: district ?? this.district,
        host: host ?? this.host,
        travellers: travellers ?? this.travellers,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['placeName'] = placeName;
    map['description'] = description;
    map['division'] = division;
    map['startDate'] = startDate;
    map['endDate'] = endDate;
    map['photos'] = photos;
    map['joinedPersons'] = joinedPersons;
    map['status'] = status;
    map['cost'] = cost;
    map['users'] = users;
    map['hotel'] = hotel;
    map['rooms'] = rooms;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    map['district'] = district;
    map['host'] = host;
    map['travellers'] = travellers;
    return map;
  }
}
