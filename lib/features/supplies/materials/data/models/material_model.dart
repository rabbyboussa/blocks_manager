import 'package:blocks/features/supplies/materials/domain/entities/material_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'material_model.g.dart';

@JsonSerializable()
class MaterialModel extends MaterialEntity {
  const MaterialModel({
    required int id,
    required String designation,
    String? description,
    required String measurementUnit,
    required int quantity,
    String? imagePath,
  }) : super(
          id: id,
          designation: designation,
          description: description,
          measurementUnit: measurementUnit,
          quantity: quantity,
          imagePath: imagePath,
        );

  factory MaterialModel.fromJson(Map<String, dynamic> json) =>
      _$MaterialModelFromJson(json);

  Map<String, dynamic> toJson() => _$MaterialModelToJson(this);
}
