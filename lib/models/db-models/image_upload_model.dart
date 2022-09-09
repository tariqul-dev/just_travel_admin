class ImageUploadModel {
  ImageUploadModel({
    this.image,
    this.id,
    this.v,
  });


  @override
  String toString() {
    return 'ImageUploadModel{image: $image, id: $id, v: $v}';
  }

  ImageUploadModel.fromJson(dynamic json) {
    image = json['image'];
    id = json['_id'];
    v = json['__v'];
  }
  String? image;
  String? id;
  num? v;
  ImageUploadModel copyWith({
    String? image,
    String? id,
    num? v,
  }) =>
      ImageUploadModel(
        image: image ?? this.image,
        id: id ?? this.id,
        v: v ?? this.v,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['image'] = image;
    map['_id'] = id;
    map['__v'] = v;
    return map;
  }
}
