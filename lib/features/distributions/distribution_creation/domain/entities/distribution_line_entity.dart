import 'package:equatable/equatable.dart';

class DistributionLineEntity extends Equatable {
  const DistributionLineEntity({
    this.id,
    this.distributionId,
    required this.product,
    required this.quantity,
  });

  final int? id;
  final int? distributionId;
  final String product;
  final double quantity;
  @override
  List<Object?> get props => [
        id,
        distributionId,
        product,
        quantity,
      ];
}
