class Review {
  final int? id;
  final int? rating;
  final String? comment;
  final int? userId;
  final int? businessId;

  const Review({
    this.id,
    this.rating,
    this.comment,
    this.userId,
    this.businessId,
  });

  Review.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        rating = json['rating'],
        comment = json['comment'],
        userId = json['user_id'],
        businessId = json['business_id'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'rating': rating,
        'comment': comment,
        'user_id': userId,
        'business_id': businessId,
      };
}
