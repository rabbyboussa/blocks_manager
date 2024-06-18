import 'package:blocks/features/supplies/supplies/domain/entities/supply_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'supply_model.g.dart';

@JsonSerializable()
class SupplyModel extends SupplyEntity {
  const SupplyModel({
    required int id,
    required int siteId,
    required String reference,
    required String supplier,
    required String creationDate,
    required String operator,
  }) : super(
          id: id,
          siteId: siteId,
          reference: reference,
          supplier: supplier,
          creationDate: creationDate,
          operator: operator,
        );

  factory SupplyModel.fromJson(Map<String, dynamic> json) =>
      _$SupplyModelFromJson(json);

  Map<String, dynamic> toJson() => _$SupplyModelToJson(this);
}
