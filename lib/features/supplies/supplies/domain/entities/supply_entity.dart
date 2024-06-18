import 'package:equatable/equatable.dart';

class SupplyEntity extends Equatable {
  const SupplyEntity({
    this.id,
    required this.siteId,
    required this.reference,
    required this.supplier,
    required this.creationDate,
    required this.operator,
  });

  final int? id;
  final int siteId;
  final String reference;
  final String supplier;
  final String creationDate;
  final String operator;

  SupplyEntity copyWith({
    int? id,
    int? siteId,
    String? reference,
    String? supplier,
    String? creationDate,
    String? operator,
  }) {
    return SupplyEntity(
      id: id ?? this.id,
      siteId: siteId ?? this.siteId,
      reference: reference ?? this.reference,
      supplier: supplier ?? this.supplier,
      creationDate: creationDate ?? this.creationDate,
      operator: operator ?? this.operator,
    );
  }

  @override
  List<Object?> get props => [
        id,
        siteId,
        reference,
        supplier,
        creationDate,
        operator,
      ];
}
