import 'package:json_annotation/json_annotation.dart';
import 'package:recipe_blog_app/Model/recipeType.dart';

import 'addBlogModels.dart';

part 'CategorySuperModel.g.dart';

@JsonSerializable()
class CategorySuperModel {
  List<RecipeTypeModel?>? data;
  CategorySuperModel({this.data});
  factory CategorySuperModel.fromJson(Map<String, dynamic> json) =>
      _$SuperModelFromJson(json);
  Map<String, dynamic> toJson() => _$SuperModelToJson(this);
}
