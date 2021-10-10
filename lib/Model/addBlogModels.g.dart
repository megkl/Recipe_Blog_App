// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addBlogModels.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddBlogModel _$AddBlogModelFromJson(Map<String, dynamic> json) {
  return AddBlogModel(
    coverImage: json['coverImage'] as String,
    duration: json['duration'] as int,
    procedure: json['procedure'] as String,
    ingredients: json['ingredients'] as List,
    productTypeName: json['productTypeName'] as String,
    id: json['_id'] as String,
    username: json['username'] as String,
    body: json['body'] as String,
    title: json['title'] as String,
    isFavourite: json['isFavourite'] as bool,
    isFeatured: json['isFeatured'] as bool,

  );
}

Map<String, dynamic> _$AddBlogModelToJson(AddBlogModel instance) =>
    <String, dynamic>{
      'coverImage': instance.coverImage,
      'duration' : instance.duration,
      'procedure': instance.procedure,
      'productTypeName': instance.productTypeName,
      'ingredients': instance.ingredients,
      '_id': instance.id,
      'username': instance.username,
      'title': instance.title,
      'body': instance.body,
      'isFeatured': instance.isFeatured,
      'isFavourite': instance.isFavourite
    };
