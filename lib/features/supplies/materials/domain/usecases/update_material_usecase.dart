import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/core/usecases/usecase.dart';
import 'package:blocks/features/supplies/materials/domain/entities/material_entity.dart';
import 'package:blocks/features/supplies/materials/domain/repositories/materials_repository.dart';
import 'package:equatable/equatable.dart';

class UpdateMaterialUsecase
    extends Usecase<ResultFutureVoid, UpdateMaterialUsecaseParams> {
  const UpdateMaterialUsecase({required MaterialsRepository repository})
      : _repository = repository;

  final MaterialsRepository _repository;

  @override
  ResultFutureVoid call(UpdateMaterialUsecaseParams params) async =>
      _repository.updateMaterial(material: params.material);
}

class UpdateMaterialUsecaseParams extends Equatable {
  const UpdateMaterialUsecaseParams({required this.material});

  final MaterialEntity material;

  @override
  List<Object?> get props => [material];
}
