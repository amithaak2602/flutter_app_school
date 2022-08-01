class RegistrationModel {
  int? id, student,subject;
  RegistrationModel({
    this.id,
    this.subject,
    this.student,

  });

  factory RegistrationModel.fromJson (dynamic json) {
    return new RegistrationModel(
      id: json["id"],
      student: json['student'],
      subject: json['subject'],

    );
  }
}
