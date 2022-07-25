class ClassRoomModel {
  String? name, layout;
  int? id, size;
  ClassRoomModel({
    this.id,
    this.name,
    this.size,this.layout,

  });

  factory ClassRoomModel.fromJson (dynamic json) {
    return new ClassRoomModel(
      id: json["id"],
      layout: json['layout'],
      name: json['name'],
      size: json['size'],

    );
  }
}
