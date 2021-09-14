// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CategorySuperModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategorySuperModel _$SuperModelFromJson(Map<String, dynamic> json) {
  return CategorySuperModel(
    data: (json['data'] as List)
        .map((e) =>
            e == null ? null : RecipeTypeModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$SuperModelToJson(CategorySuperModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
