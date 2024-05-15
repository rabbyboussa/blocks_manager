import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/core/usecases/usecase.dart';
import 'package:blocks/features/distributions/distribution_creation/domain/entities/distribution_line_entity.dart';
import 'package:blocks/features/distributions/distribution_creation/domain/repository/distribution_creation_repository.dart';
import 'package:blocks/features/productions/products/domain/entities/product_entity.dart';
import 'package:equatable/equatable.dart';

class CreateDistributionUsecase
    extends Usecase<ResultFutureVoid, CreateDistributionUsecaseParams> {
  const CreateDistributionUsecase(
      {required DistributionCreationRepository repository})
      : _repository = repository;

  final DistributionCreationRepository _repository;

  @override
  ResultFutureVoid call(CreateDistributionUsecaseParams params) async =>
      _repository.createDistribution(
        reference: params.reference,
        clientId: params.clientId,
        creationDate: params.creationDate,
        accountId: params.accountId,
        products: params.products,
        lines: params.lines,
      );
}

class CreateDistributionUsecaseParams extends Equatable {
  const CreateDistributionUsecaseParams({
    required this.reference,
    required this.clientId,
    required this.creationDate,
    required this.accountId,
    required this.products,
    required this.lines,
  });

  final String reference;
  final int clientId;
  final String creationDate;
  final int accountId;
  final List<ProductEntity> products;
  final List<DistributionLineEntity> lines;

  @override
  List<Object?> get props => [
        reference,
        clientId,
        creationDate,
        accountId,
        products,
        lines,
      ];
}
