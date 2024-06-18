import 'package:equatable/equatable.dart';

class ProductionEntity extends Equatable {
  const ProductionEntity({
    this.id,
    required this.siteId,
    required this.reference,
    required this.creationDate,
    required this.operator,
  });

  final int? id;
  final int siteId;
  final String reference;
  final String creationDate;
  final String operator;

  ProductionEntity copyWith({
    int? id,
    int? siteId,
    String? reference,
    String? creationDate,
    String? operator,
  }) {
    return ProductionEntity(
      id: id ?? this.id,
      siteId: siteId ?? this.siteId,
      reference: reference ?? this.reference,
      creationDate: creationDate ?? this.creationDate,
      operator: operator ?? this.operator,
    );
  }

  @override
  List<Object?> get props => [
        id,
        siteId,
        reference,
        creationDate,
        operator,
      ];
}
