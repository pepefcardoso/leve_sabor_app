import 'package:freezed_annotation/freezed_annotation.dart';

part 'diet.freezed.dart';
part 'diet.g.dart';

@freezed
class Diet with _$Diet {
  const factory Diet({
    int? id,
    String? name,
  }) = _Diet;

  factory Diet.fromJson(Map<String, dynamic> json) => _$DietFromJson(json);
}