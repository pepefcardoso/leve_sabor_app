class RatingsInfo {
  final int? count;
  final double? average;

  const RatingsInfo({
    this.count,
    this.average,
  });

  RatingsInfo.fromJson(Map<String, dynamic> json)
      : count = json['total_reviews'],
        average = json['average_rating'];

  Map<String, dynamic> toJson() => {
        'total_reviews': count,
        'average_rating': average,
      };
}
