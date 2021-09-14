import 'package:json_annotation/json_annotation.dart';

part 'addBlogModels.g.dart';

@JsonSerializable()
class AddBlogModel {
  String coverImage;
  int duration;
  String productTypeName;
  String procedure;
  String ingredients;
  @JsonKey(name: "_id")
  String id;
  String username;
  String title;
  String body;
  
  AddBlogModel(
      {
      required this.coverImage,
      required this.duration,
      required this.productTypeName,
      required this.procedure,
      required this.ingredients,
      required this.id,
      required this.username,
      required this.body,
      required this.title});
  factory AddBlogModel.fromJson(Map<String, dynamic> json) =>
      _$AddBlogModelFromJson(json);
  Map<String, dynamic> toJson() => _$AddBlogModelToJson(this);
}
