part of 'supply_creation_bloc.dart';

sealed class SupplyCreationEvent extends Equatable {
  const SupplyCreationEvent();

  @override
  List<Object> get props => [];
}

final class FetchDataEvent extends SupplyCreationEvent {
  const FetchDataEvent({required this.siteId});

  final int siteId;

  @override
  List<Object> get props => [siteId];
}

final class CreateSupplyEvent extends SupplyCreationEvent {
  const CreateSupplyEvent({
    required this.siteId,
    required this.reference,
    required this.supplierId,
    required this.creationDate,
    required this.accountId,
    required this.materials,
    required this.lines,
  });

  final int siteId;
  final String reference;
  final int supplierId;
  final String creationDate;
  final int accountId;
  final List<MaterialEntity> materials;
  final List<SupplyLineEntity> lines;

  @override
  List<Object> get props => [
        siteId,
        reference,
        supplierId,
        creationDate,
        accountId,
        materials,
        lines,
      ];
}
