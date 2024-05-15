import 'package:blocks/features/productions/productions/domain/entities/production_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'production_model.g.dart';

@JsonSerializable()
class ProductionModel extends ProductionEntity {
  const ProductionModel({
    required int id,
    required String reference,
    required String creationDate,
    required String operator,
  }) : super(
          id: id,
          reference: reference,
          creationDate: creationDate,
          operator: operator,
        );

  factory ProductionModel.fromJson(Map<String, dynamic> json) =>
      _$ProductionModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionModelToJson(this);
}
