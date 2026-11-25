import 'package:json_annotation/json_annotation.dart';

part 'project.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Project {
  static const int titleMaxLength = 255;
  static const int urlMaxLength = 200;

  const Project({
    this.id,
    required this.title,
    required this.description,
    this.sourceUrl = '',
    this.liveUrl = '',
    this.starCount = 0,
    this.isStarred = false,
    this.starredByNames = '',
  });

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  @JsonKey(includeToJson: false)
  final int? id;
  final String title;
  final String description;
  @JsonKey(defaultValue: '')
  final String sourceUrl;
  @JsonKey(defaultValue: '')
  final String liveUrl;
  @JsonKey(includeToJson: false, defaultValue: 0)
  final int starCount;
  @JsonKey(includeToJson: false, defaultValue: false)
  final bool isStarred;
  @JsonKey(includeToJson: false, defaultValue: '')
  final String starredByNames;

  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
