import 'package:freezed_annotation/freezed_annotation.dart';
import 'user_image.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const User._();

  const factory User({
    int? id,
    String? name,
    String? email,
    DateTime? birthday,
    String? phone,
    String? cpf,
    @JsonKey(name: 'user_image') UserImage? image,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  String? get firstName => name?.split(' ')[0];
}