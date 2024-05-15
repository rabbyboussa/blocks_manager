import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/core/usecases/usecase.dart';
import 'package:blocks/features/supplies/materials/domain/entities/material_entity.dart';
import 'package:blocks/features/supplies/materials/domain/repositories/materials_repository.dart';
import 'package:equatable/equatable.dart';

class AddMaterialUsecase
    extends Usecase<ResultFuture<MaterialEntity>, AddMaterialUsecaseParams> {
  const AddMaterialUsecase({required MaterialsRepository repository})
      : _repository = repository;

  final MaterialsRepository _repository;

  @override
  ResultFuture<MaterialEntity> call(AddMaterialUsecaseParams params) async =>
      _repository.addMaterial(material: params.material);
}

class AddMaterialUsecaseParams extends Equatable {
  const AddMaterialUsecaseParams({
    required this.material,
  });

  final MaterialEntity material;

  @override
  List<Object?> get props => [material];
}
