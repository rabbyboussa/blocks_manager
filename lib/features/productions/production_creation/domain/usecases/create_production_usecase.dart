import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/core/usecases/usecase.dart';
import 'package:blocks/features/productions/production_creation/domain/entities/material_used_line_entity.dart';
import 'package:blocks/features/productions/production_creation/domain/entities/production_line_entity.dart';
import 'package:blocks/features/productions/production_creation/domain/repository/production_creation_repository.dart';
import 'package:blocks/features/productions/products/domain/entities/product_entity.dart';
import 'package:blocks/features/supplies/materials/domain/entities/material_entity.dart';
import 'package:equatable/equatable.dart';

class CreateProductionUsecase
    extends Usecase<ResultFutureVoid, CreateProductionUsecaseParams> {
  const CreateProductionUsecase(
      {required ProductionCreationRepository repository})
      : _repository = repository;

  final ProductionCreationRepository _repository;

  @override
  ResultFutureVoid call(CreateProductionUsecaseParams params) async =>
      _repository.createProduction(
        reference: params.reference,
        creationDate: params.creationDate,
        accountId: params.accountId,
        siteId: params.siteId,
        products: params.products,
        materials: params.materials,
        productionlines: params.productionlines,
        materialsUsedLines: params.materialsUsedLines,
      );
}

class CreateProductionUsecaseParams extends Equatable {
  const CreateProductionUsecaseParams({
    required this.reference,
    required this.creationDate,
    required this.accountId,
    required this.siteId,
    required this.products,
    required this.materials,
    required this.productionlines,
    required this.materialsUsedLines,
  });

  final String reference;
  final String creationDate;
  final int accountId;
  final int siteId;
  final List<ProductEntity> products;
  final List<MaterialEntity> materials;
  final List<ProductionLineEntity> productionlines;
  final List<MaterialUsedLineEntity> materialsUsedLines;

  @override
  List<Object?> get props => [
        reference,
        creationDate,
        accountId,
        siteId,
        products,
        productionlines,
        materialsUsedLines,
      ];
}
