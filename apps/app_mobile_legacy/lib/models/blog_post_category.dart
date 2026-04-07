class BlogPostCategory {
  final int? id;
  final String? name;

  BlogPostCategory({
    this.id,
    this.name,
  });

  BlogPostCategory.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];
}
