import 'package:blocks/features/supplies/supply_creation/domain/entities/supply_line_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'supply_line_model.g.dart';

@JsonSerializable()
class SupplyLineModel extends SupplyLineEntity {
  const SupplyLineModel({
    required int id,
    required int supplyId,
    required String material,
    required double quantity,
  }) : super(
          id: id,
          supplyId: supplyId,
          material: material,
          quantity: quantity,
        );

  factory SupplyLineModel.fromJson(Map<String, dynamic> json) =>
      _$SupplyLineModelFromJson(json);

  Map<String, dynamic> toJson() => _$SupplyLineModelToJson(this);
}
