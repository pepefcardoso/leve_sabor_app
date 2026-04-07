import 'package:freezed_annotation/freezed_annotation.dart';

part 'phone.freezed.dart';
part 'phone.g.dart';

@freezed
class Phone with _$Phone {
  const factory Phone({
    int? id,
    String? number,
    bool? whatsapp,
    @JsonKey(name: 'contact_id') int? contactId,
  }) = _Phone;

  factory Phone.fromJson(Map<String, dynamic> json) => _$PhoneFromJson(json);
}