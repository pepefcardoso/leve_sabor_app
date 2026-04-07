import 'package:freezed_annotation/freezed_annotation.dart';

part 'address.freezed.dart';
part 'address.g.dart';

@freezed
class Address with _$Address {
  const factory Address({
    int? id,
    String? street,
    String? number,
    String? complement,
    String? district,
    String? city,
    String? state,
    @JsonKey(name: 'zip_code') String? zipCode,
    double? latitude,
    double? longitude,
    @JsonKey(name: 'business_id') int? businessId,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
}