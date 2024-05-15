import 'package:blocks/features/productions/production_creation/domain/entities/material_used_line_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'material_used_line_model.g.dart';

@JsonSerializable()
class MaterialUsedLineModel extends MaterialUsedLineEntity {
  const MaterialUsedLineModel({
    required int id,
    required int productionId,
    required String material,
    required double quantity,
  }) : super(
          id: id,
          productionId: productionId,
          material: material,
          quantity: quantity,
        );

  factory MaterialUsedLineModel.fromJson(Map<String, dynamic> json) =>
      _$MaterialUsedLineModelFromJson(json);

  Map<String, dynamic> toJson() => _$MaterialUsedLineModelToJson(this);
}
