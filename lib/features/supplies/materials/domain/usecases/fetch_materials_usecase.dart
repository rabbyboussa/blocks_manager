import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/core/usecases/usecase.dart';
import 'package:blocks/features/supplies/materials/domain/entities/material_entity.dart';
import 'package:blocks/features/supplies/materials/domain/repositories/materials_repository.dart';

class FetchMaterialsUsecase
    extends UsecaseWithoutParams<ResultFuture<List<MaterialEntity>>> {
  const FetchMaterialsUsecase({required MaterialsRepository repository})
      : _repository = repository;

  final MaterialsRepository _repository;

  @override
  ResultFuture<List<MaterialEntity>> call() async =>
      _repository.fetchMaterials();
}
