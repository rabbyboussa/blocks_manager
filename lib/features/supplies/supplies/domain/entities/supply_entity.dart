import 'package:equatable/equatable.dart';

class SupplyEntity extends Equatable {
  const SupplyEntity({
    this.id,
    required this.reference,
    required this.supplier,
    required this.creationDate,
    required this.operator,
  });

  final int? id;
  final String reference;
  final String supplier;
  final String creationDate;
  final String operator;

  SupplyEntity copyWith({
    int? id,
    String? reference,
    String? supplier,
    String? creationDate,
    String? operator,
  }) {
    return SupplyEntity(
      id: id ?? this.id,
      reference: reference ?? this.reference,
      supplier: supplier ?? this.supplier,
      creationDate: creationDate ?? this.creationDate,
      operator: operator ?? this.operator,
    );
  }

  @override
  List<Object?> get props => [
        id,
        reference,
        supplier,
        creationDate,
        operator,
      ];
}
