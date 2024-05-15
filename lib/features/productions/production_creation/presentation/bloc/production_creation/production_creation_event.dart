part of 'production_creation_bloc.dart';

sealed class ProductionCreationEvent extends Equatable {
  const ProductionCreationEvent();

  @override
  List<Object> get props => [];
}

final class FetchDataEvent extends ProductionCreationEvent {}

final class CreateProductionEvent extends ProductionCreationEvent {
  const CreateProductionEvent({
    required this.reference,
    required this.creationDate,
    required this.accountId,
    required this.products,
    required this.materials,
    required this.productionLines,
    required this.materialsUsedLines,
  });

  final String reference;
  final String creationDate;
  final int accountId;
  final List<ProductEntity> products;
  final List<MaterialEntity> materials;
  final List<ProductionLineEntity> productionLines;
  final List<MaterialUsedLineEntity> materialsUsedLines;

  @override
  List<Object> get props => [
        reference,
        creationDate,
        accountId,
        products,
        productionLines,
        materialsUsedLines,
      ];
}
