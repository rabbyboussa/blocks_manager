import 'package:blocks/features/distributions/distributions/domain/entities/distribution_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'distribution_model.g.dart';

@JsonSerializable()
class DistributionModel extends DistributionEntity {
  const DistributionModel({
    required int id,
    required String reference,
    required String client,
    required String creationDate,
    required String operator,
  }) : super(
          id: id,
          reference: reference,
          client: client,
          creationDate: creationDate,
          operator: operator,
        );

  factory DistributionModel.fromJson(Map<String, dynamic> json) =>
      _$DistributionModelFromJson(json);

  Map<String, dynamic> toJson() => _$DistributionModelToJson(this);
}
