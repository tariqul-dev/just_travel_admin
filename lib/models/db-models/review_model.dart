class ReviewModel {
  ReviewModel({
    this.review,
    this.trip,
    this.user,
    this.date,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  ReviewModel.fromJson(dynamic json) {
    review = json['review'];
    trip = json['trip'];
    user = json['user'];
    date = json['date'];
    id = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? review;
  String? trip;
  String? user;
  num? date;
  String? id;
  String? createdAt;
  String? updatedAt;
  num? v;
  ReviewModel copyWith({
    String? review,
    String? trip,
    String? user,
    num? date,
    String? id,
    String? createdAt,
    String? updatedAt,
    num? v,
  }) =>
      ReviewModel(
        review: review ?? this.review,
        trip: trip ?? this.trip,
        user: user ?? this.user,
        date: date ?? this.date,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['review'] = review;
    map['trip'] = trip;
    map['user'] = user;
    return map;
  }
}
