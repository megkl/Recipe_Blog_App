import 'package:json_annotation/json_annotation.dart';

part 'recipeType.g.dart';

@JsonSerializable()
class RecipeTypeModel {
  String coverImage;
  String productTypeName;
  @JsonKey(name: "_id")
  String id;
  
  RecipeTypeModel(
      {
      required this.coverImage,
      required this.productTypeName,
      required this.id,

      });
  factory RecipeTypeModel.fromJson(Map<String, dynamic> json) =>
      _$AddBlogModelFromJson(json);
  Map<String, dynamic> toJson() => _$AddBlogModelToJson(this);
}
