class UserModel {
  UserModel({
    this.email,
    this.mobile,
    this.id,
    this.name,
    this.district,
    this.division,
    this.profileImage,
    this.coverImage,
    this.uploadImages,
    this.trips,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  @override
  String toString() {
    return 'UserModel{email: $email, mobile: $mobile, id: $id, name: $name, district: $district, division: $division, profileImage: $profileImage, coverImage: $coverImage, uploadImages: $uploadImages, trips: $trips, createdAt: $createdAt, updatedAt: $updatedAt, v: $v}';
  }

  UserModel.fromJson(dynamic json) {
    email = json['email'] != null ? Email.fromJson(json['email']) : null;
    mobile = json['mobile'] != null ? Mobile.fromJson(json['mobile']) : null;
    id = json['_id'];
    name = json['name'];
    district = json['district'];
    division = json['division'];
    profileImage = json['profileImage'];
    coverImage = json['coverImage'];
    uploadImages =
        json['uploadImages'] != null ? json['uploadImages'].cast<String>() : [];
    trips = json['trips'] != null ? json['trips'].cast<String>() : [];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  Email? email;
  Mobile? mobile;
  String? id;
  String? name;
  String? district;
  String? division;
  String? profileImage;
  String? coverImage;
  List<String>? uploadImages;
  List<String>? trips;
  String? createdAt;
  String? updatedAt;
  num? v;
  UserModel copyWith({
    Email? email,
    Mobile? mobile,
    String? id,
    String? name,
    String? district,
    String? division,
    String? profileImage,
    String? coverImage,
    List<String>? uploadImages,
    List<String>? trips,
    String? createdAt,
    String? updatedAt,
    num? v,
  }) =>
      UserModel(
        email: email ?? this.email,
        mobile: mobile ?? this.mobile,
        id: id ?? this.id,
        name: name ?? this.name,
        district: district ?? this.district,
        division: division ?? this.division,
        profileImage: profileImage ?? this.profileImage,
        coverImage: coverImage ?? this.coverImage,
        uploadImages: uploadImages ?? this.uploadImages,
        trips: trips ?? this.trips,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (email != null) {
      map['email'] = email?.toJson();
    }
    if (mobile != null) {
      map['mobile'] = mobile?.toJson();
    }
    map['name'] = name;
    map['district'] = district;
    map['division'] = division;
    map['profileImage'] = profileImage;
    map['coverImage'] = coverImage;
    map['uploadImages'] = uploadImages;
    map['trips'] = trips;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
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
