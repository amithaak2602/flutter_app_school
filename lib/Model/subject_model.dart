class SubjectsModel {
  String? name, teacher;
  int? id, credits;
  SubjectsModel({
    this.id,
    this.name,
    this.credits,this.teacher,

  });

  factory SubjectsModel.fromJson (dynamic json) {
    return new SubjectsModel(
      id: json["id"],
      credits: json['credits'],
      name: json['name'],
      teacher: json['teacher'],

    );
  }
}
