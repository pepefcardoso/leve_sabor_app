class Image {
  final int? id;
  final String? path;
  final String? type;
  final String? url;
  final int? businessId;

  const Image({
    this.id,
    this.path,
    this.type,
    this.url,
    this.businessId,
  });

  Image.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        path = json['path'],
        type = json['type'],
        url = json['url'],
        businessId = json['business_id'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'path': path,
        'type': type,
        'url': url,
        'business_id': businessId,
      };
}
