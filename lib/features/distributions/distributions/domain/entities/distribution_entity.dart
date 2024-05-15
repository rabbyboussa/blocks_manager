import 'package:equatable/equatable.dart';

class DistributionEntity extends Equatable {
  const DistributionEntity({
    this.id,
    required this.reference,
    required this.client,
    required this.creationDate,
    required this.operator,
  });

  final int? id;
  final String reference;
  final String client;
  final String creationDate;
  final String operator;

  DistributionEntity copyWith({
    int? id,
    String? reference,
    String? client,
    String? creationDate,
    String? operator,
  }) {
    return DistributionEntity(
      id: id ?? this.id,
      reference: reference ?? this.reference,
      client: client ?? this.client,
      creationDate: creationDate ?? this.creationDate,
      operator: operator ?? this.operator,
    );
  }

  @override
  List<Object?> get props => [
        id,
        reference,
        client,
        creationDate,
        operator,
      ];
}
