import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/core/usecases/usecase.dart';
import 'package:blocks/features/supplies/materials/domain/entities/material_entity.dart';
import 'package:blocks/features/supplies/supply_creation/domain/entities/supply_line_entity.dart';
import 'package:blocks/features/supplies/supply_creation/domain/repository/supply_creation_repository.dart';
import 'package:equatable/equatable.dart';

class CreateSupplyUsecase
    extends Usecase<ResultFutureVoid, CreateSupplyUsecaseParams> {
  const CreateSupplyUsecase({required SupplyCreationRepository repository})
      : _repository = repository;

  final SupplyCreationRepository _repository;

  @override
  ResultFutureVoid call(CreateSupplyUsecaseParams params) async =>
      _repository.createSupply(
        reference: params.reference,
        supplierId: params.supplierId,
        creationDate: params.creationDate,
        accountId: params.accountId,
        materials: params.materials,
        lines: params.lines,
      );
}

class CreateSupplyUsecaseParams extends Equatable {
  const CreateSupplyUsecaseParams({
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
  List<Object?> get props => [
        reference,
        supplierId,
        creationDate,
        accountId,
        materials,
        lines,
      ];
}
