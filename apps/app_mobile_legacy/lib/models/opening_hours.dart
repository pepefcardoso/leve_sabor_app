class OpeningHours {
  final int? id;
  final DateTime? specificDate;
  final int? dayOfWeek;
  final DateTime? openingTime;
  final DateTime? closingTime;
  final DateTime? openingTime2;
  final DateTime? closingTime2;
  final int? businessId;

  const OpeningHours({
    this.id,
    this.specificDate,
    this.dayOfWeek,
    this.openingTime,
    this.closingTime,
    this.openingTime2,
    this.closingTime2,
    this.businessId,
  });

  OpeningHours.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        specificDate = json['specificDate'] != null ? DateTime.parse(json['specificDate']) : null,
        dayOfWeek = json['dayOfWeek'],
        openingTime = json['openingTime'] != null ? DateTime.parse(json['openingTime']) : null,
        closingTime = json['closingTime'] != null ? DateTime.parse(json['closingTime']) : null,
        openingTime2 = json['openingTime2'] != null ? DateTime.parse(json['openingTime2']) : null,
        closingTime2 = json['closingTime2'] != null ? DateTime.parse(json['closingTime2']) : null,
        businessId = json['businessId'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'specificDate': specificDate?.toIso8601String(),
        'dayOfWeek': dayOfWeek,
        'openingTime': openingTime?.toIso8601String(),
        'closingTime': closingTime?.toIso8601String(),
        'openingTime2': openingTime2?.toIso8601String(),
        'closingTime2': closingTime2?.toIso8601String(),
        'businessId': businessId,
      };
}
