import 'package:equatable/equatable.dart';

class DistributionEntity extends Equatable {
  const DistributionEntity({
    this.id,
    required this.siteId,
    required this.reference,
    required this.client,
    required this.creationDate,
    required this.operator,
  });

  final int? id;
  final int siteId;
  final String reference;
  final String client;
  final String creationDate;
  final String operator;

  DistributionEntity copyWith({
    int? id,
    int? siteId,
    String? reference,
    String? client,
    String? creationDate,
    String? operator,
  }) {
    return DistributionEntity(
      id: id ?? this.id,
      siteId: siteId ?? this.siteId,
      reference: reference ?? this.reference,
      client: client ?? this.client,
      creationDate: creationDate ?? this.creationDate,
      operator: operator ?? this.operator,
    );
  }

  @override
  List<Object?> get props => [
        id,
        siteId,
        reference,
        client,
        creationDate,
        operator,
      ];
}
