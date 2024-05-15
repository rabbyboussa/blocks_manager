import 'package:blocks/features/productions/production_creation/domain/entities/production_line_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'production_line_model.g.dart';

@JsonSerializable()
class ProductionLineModel extends ProductionLineEntity {
  const ProductionLineModel({
    required int id,
    required int productionId,
    required String product,
    required double quantity,
  }) : super(
          id: id,
          productionId: productionId,
          product: product,
          quantity: quantity,
        );

  factory ProductionLineModel.fromJson(Map<String, dynamic> json) =>
      _$ProductionLineModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionLineModelToJson(this);
}
