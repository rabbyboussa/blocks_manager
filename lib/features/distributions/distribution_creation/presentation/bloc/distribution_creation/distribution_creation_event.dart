part of 'distribution_creation_bloc.dart';

sealed class DistributionCreationEvent extends Equatable {
  const DistributionCreationEvent();

  @override
  List<Object> get props => [];
}

final class FetchDataEvent extends DistributionCreationEvent {}

final class CreateDistributionEvent extends DistributionCreationEvent {
  const CreateDistributionEvent({
    required this.reference,
    required this.siteId,
    required this.clientId,
    required this.creationDate,
    required this.accountId,
    required this.products,
    required this.lines,
  });

  final String reference;
  final int siteId;
  final int clientId;
  final String creationDate;
  final int accountId;
  final List<ProductEntity> products;
  final List<DistributionLineEntity> lines;

  @override
  List<Object> get props => [
        reference,
        siteId,
        clientId,
        creationDate,
        accountId,
        products,
        lines,
      ];
}
