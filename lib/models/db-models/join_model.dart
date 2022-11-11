class JoinModel {
  JoinModel({
    this.tripId,
    this.userId,
    this.roomId,
    this.numberOfTravellers,
    this.startDate,
    this.endDate,
    this.status,
    this.totalCost,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  JoinModel.fromJson(dynamic json) {
    tripId = json['tripId'];
    userId = json['userId'];
    roomId = json['roomId'];
    numberOfTravellers = json['numberOfTravellers'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    status = json['status'];
    totalCost = json['totalCost'];
    id = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? tripId;
  String? userId;
  String? roomId;
  num? numberOfTravellers;
  num? startDate;
  num? endDate;
  String? status;
  num? totalCost;
  String? id;
  String? createdAt;
  String? updatedAt;
  num? v;
  JoinModel copyWith({
    String? tripId,
    String? userId,
    String? roomId,
    num? numberOfTravellers,
    num? startDate,
    num? endDate,
    String? status,
    num? totalCost,
    String? id,
    String? createdAt,
    String? updatedAt,
    num? v,
  }) =>
      JoinModel(
        tripId: tripId ?? this.tripId,
        userId: userId ?? this.userId,
        roomId: roomId ?? this.roomId,
        numberOfTravellers: numberOfTravellers ?? this.numberOfTravellers,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        status: status ?? this.status,
        totalCost: totalCost ?? this.totalCost,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tripId'] = tripId;
    map['userId'] = userId;
    map['roomId'] = roomId;
    map['numberOfTravellers'] = numberOfTravellers;
    map['startDate'] = startDate;
    map['endDate'] = endDate;
    map['totalCost'] = totalCost;
    return map;
  }
}
