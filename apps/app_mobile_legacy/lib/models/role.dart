class Role {
  final int? id;
  final String? name;

  const Role({
    this.id,
    this.name,
  });

  Role.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
