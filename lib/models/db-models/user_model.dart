class UserModel {
  UserModel({
    this.name,
    this.email,
    this.mobile,
    this.division,
    this.district,
    this.profileImage,
    this.coverImage,
    this.uploadImages,
    this.dob,
    this.about,
    this.gender,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  UserModel.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'] != null ? Email.fromJson(json['email']) : null;
    mobile = json['mobile'] != null ? Mobile.fromJson(json['mobile']) : null;
    division = json['division'];
    district = json['district'];
    profileImage = json['profileImage'];
    coverImage = json['coverImage'];
    uploadImages =
        json['uploadImages'] != null ? json['uploadImages'].cast<String>() : [];
    dob = json['dob'];
    about = json['about'];
    gender = json['gender'];
    id = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? name;
  Email? email;
  Mobile? mobile;
  String? division;
  String? district;
  String? profileImage;
  String? coverImage;
  List<String>? uploadImages;
  num? dob;
  String? about;
  String? gender;
  String? id;
  String? createdAt;
  String? updatedAt;
  num? v;
  UserModel copyWith({
    String? name,
    Email? email,
    Mobile? mobile,
    String? division,
    String? district,
    String? profileImage,
    String? coverImage,
    List<String>? uploadImages,
    num? dob,
    String? about,
    String? gender,
    String? id,
    String? createdAt,
    String? updatedAt,
    num? v,
  }) =>
      UserModel(
        name: name ?? this.name,
        email: email ?? this.email,
        mobile: mobile ?? this.mobile,
        division: division ?? this.division,
        district: district ?? this.district,
        profileImage: profileImage ?? this.profileImage,
        coverImage: coverImage ?? this.coverImage,
        uploadImages: uploadImages ?? this.uploadImages,
        dob: dob ?? this.dob,
        about: about ?? this.about,
        gender: gender ?? this.gender,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    if (email != null) {
      map['email'] = email?.toJson();
    }
    if (mobile != null) {
      map['mobile'] = mobile?.toJson();
    }
    map['division'] = division;
    map['district'] = district;
    map['profileImage'] = profileImage;
    map['coverImage'] = coverImage;
    map['uploadImages'] = uploadImages;
    map['dob'] = dob;
    map['about'] = about;
    map['gender'] = gender;
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
