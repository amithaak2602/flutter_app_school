class ClassRoomModel {
  String? name, layout,subjectName,teacher;
  int? id, size,subject,credits;
  ClassRoomModel({
    this.id,
    this.name,
    this.size,this.layout,this.subject,

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
