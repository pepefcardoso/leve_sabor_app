class CookingStyle {
  final int? id;
  final String? name;

  const CookingStyle({
    this.id,
    this.name,
  });

  CookingStyle.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
