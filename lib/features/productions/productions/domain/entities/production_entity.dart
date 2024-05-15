import 'package:equatable/equatable.dart';

class ProductionEntity extends Equatable {
  const ProductionEntity({
    this.id,
    required this.reference,
    required this.creationDate,
    required this.operator,
  });

  final int? id;
  final String reference;
  final String creationDate;
  final String operator;

  ProductionEntity copyWith({
    int? id,
    String? reference,
    String? creationDate,
    String? operator,
  }) {
    return ProductionEntity(
      id: id ?? this.id,
      reference: reference ?? this.reference,
      creationDate: creationDate ?? this.creationDate,
      operator: operator ?? this.operator,
    );
  }

  @override
  List<Object?> get props => [
        id,
        reference,
        creationDate,
        operator,
      ];
}
