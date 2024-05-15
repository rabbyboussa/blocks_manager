import 'package:equatable/equatable.dart';

class SupplyLineEntity extends Equatable {
  const SupplyLineEntity({
    this.id,
    this.supplyId,
    required this.material,
    required this.quantity,
  });

  final int? id;
  final int? supplyId;
  final String material;
  final double quantity;
  @override
  List<Object?> get props => [
        id,
        supplyId,
        material,
        quantity,
      ];
}
