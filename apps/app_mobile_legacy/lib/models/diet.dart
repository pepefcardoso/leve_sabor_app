class Diet {
  final int? id;
  final String? name;

  const Diet({
    this.id,
    this.name,
  });

  Diet.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
