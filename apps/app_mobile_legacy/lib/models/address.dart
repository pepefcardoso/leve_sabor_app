class Address {
  final int? id;
  final String? street;
  final String? number;
  final String? complement;
  final String? district;
  final String? city;
  final String? state;
  final String? zipCode;
  final double? latitude;
  final double? longitude;
  final int? businessId;

  Address({
    this.id,
    this.street,
    this.number,
    this.complement,
    this.district,
    this.city,
    this.state,
    this.zipCode,
    this.latitude,
    this.longitude,
    this.businessId,
  });

  Address.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        street = json['street'],
        number = json['number'],
        complement = json['complement'],
        district = json['district'],
        city = json['city'],
        state = json['state'],
        zipCode = json['zip_code'],
        latitude = json['latitude'],
        longitude = json['longitude'],
        businessId = json['business_id'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'street': street,
      'number': number,
      'complement': complement,
      'district': district,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'latitude': latitude,
      'longitude': longitude,
      'businessId': businessId,
    };
  }
}
