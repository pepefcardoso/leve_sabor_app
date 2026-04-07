import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum(valueField: 'value')
enum BlogPostStatusEnum {
  @JsonValue('DRAFT')
  draft('Rascunho', 'DRAFT'),
  @JsonValue('ARCHIVED')
  archived('Arquivado', 'ARCHIVED'),
  @JsonValue('PUBLISHED')
  published('Publicado', 'PUBLISHED');

  final String label;
  final String value;

  const BlogPostStatusEnum(this.label, this.value);
}