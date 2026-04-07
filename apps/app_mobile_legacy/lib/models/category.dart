class Category {
  final int? id;
  final String? name;

  const Category({
    this.id,
    this.name,
  });

  Category.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
