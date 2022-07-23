class SubCategoryModel {
  String? name, name_arabic, image_url;
  int? id, parent_id;
  SubCategoryModel({
    this.id,
    this.name,
    this.name_arabic,
    this.image_url,
    this.parent_id,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return new SubCategoryModel(
      id: json["id"],
      name: json['name'],
      name_arabic: json['name_arabic'],
      image_url: json['image_url'],
      parent_id: json['parent_id'],
    );
  }
}
