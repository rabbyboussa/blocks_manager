import 'package:equatable/equatable.dart';

class ProductionLineEntity extends Equatable {
  const ProductionLineEntity({
    this.id,
    this.productionId,
    required this.product,
    required this.quantity,
  });

  final int? id;
  final int? productionId;
  final String product;
  final double quantity;

  @override
  List<Object?> get props => [
        id,
        productionId,
        product,
        quantity,
      ];
}
