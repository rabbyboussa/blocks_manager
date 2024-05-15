import 'package:blocks/features/distributions/distribution_creation/domain/entities/distribution_line_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'distribution_line_model.g.dart';

@JsonSerializable()
class DistributionLineModel extends DistributionLineEntity {
  const DistributionLineModel({
    required int id,
    required int distributionId,
    required String product,
    required double quantity,
  }) : super(
          id: id,
          distributionId: distributionId,
          product: product,
          quantity: quantity,
        );

  factory DistributionLineModel.fromJson(Map<String, dynamic> json) =>
      _$DistributionLineModelFromJson(json);

  Map<String, dynamic> toJson() => _$DistributionLineModelToJson(this);
}
