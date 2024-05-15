part of 'supply_creation_bloc.dart';

sealed class SupplyCreationEvent extends Equatable {
  const SupplyCreationEvent();

  @override
  List<Object> get props => [];
}

final class FetchDataEvent extends SupplyCreationEvent {}

final class CreateSupplyEvent extends SupplyCreationEvent {
  const CreateSupplyEvent({
    required this.reference,
    required this.supplierId,
    required this.creationDate,
    required this.accountId,
    required this.materials,
    required this.lines,
  });

  final String reference;
  final int supplierId;
  final String creationDate;
  final int accountId;
  final List<MaterialEntity> materials;
  final List<SupplyLineEntity> lines;

  @override
  List<Object> get props => [
        reference,
        supplierId,
        creationDate,
        accountId,
        materials,
        lines,
      ];
}
