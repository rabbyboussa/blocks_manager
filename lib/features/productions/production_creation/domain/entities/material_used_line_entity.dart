import 'package:equatable/equatable.dart';

class MaterialUsedLineEntity extends Equatable {
  const MaterialUsedLineEntity({
    this.id,
    this.productionId,
    required this.material,
    required this.quantity,
  });

  final int? id;
  final int? productionId;
  final String material;
  final double quantity;
  @override
  List<Object?> get props => [
        id,
        productionId,
        material,
        quantity,
      ];
}
