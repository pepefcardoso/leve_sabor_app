import 'package:freezed_annotation/freezed_annotation.dart';
import 'phone.dart';

part 'contact.freezed.dart';
part 'contact.g.dart';

@freezed
class Contact with _$Contact {
  const factory Contact({
    int? id,
    String? email,
    String? website,
    String? facebook,
    String? instagram,
    String? ifood,
    List<Phone>? phones,
    @JsonKey(name: 'business_id') int? businessId,
  }) = _Contact;

  factory Contact.fromJson(Map<String, dynamic> json) => _$ContactFromJson(json);
}