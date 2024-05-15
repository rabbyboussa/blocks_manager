import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/features/supplies/materials/domain/entities/material_entity.dart';

abstract class MaterialsRepository {
  const MaterialsRepository();

  ResultFuture<List<MaterialEntity>> fetchMaterials();

  ResultFuture<MaterialEntity> addMaterial({required MaterialEntity material});

  ResultFutureVoid updateMaterial({required MaterialEntity material});
}
