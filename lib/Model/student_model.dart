class StudentModel {
  String? name, email;
  int? id, age;
  StudentModel({
    this.id,
    this.name,
    this.email,this.age,

  });

  factory StudentModel.fromJson (dynamic json) {
    return new StudentModel(
      id: json["id"],
      name: json['name'],
      email: json['email'],
      age: json['age'],

    );
  }
}
