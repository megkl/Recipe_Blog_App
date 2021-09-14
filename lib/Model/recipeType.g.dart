// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipeType.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeTypeModel _$AddBlogModelFromJson(Map<String, dynamic> json) {
  return RecipeTypeModel(
    coverImage: json['coverImage'] as String,
    productTypeName: json['productTypeName'] as String,
     id: json['_id'] as String,
  );
}

Map<String, dynamic> _$AddBlogModelToJson(RecipeTypeModel instance) =>
    <String, dynamic>{
      'coverImage': instance.coverImage,
      'productTypeName': instance.productTypeName,
      '_id': instance.id,

    };
