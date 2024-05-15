part of 'distribution_creation_bloc.dart';

sealed class DistributionCreationState extends Equatable {
  const DistributionCreationState();

  @override
  List<Object> get props => [];
}

final class DistributionCreationInitial extends DistributionCreationState {}

final class DataFetchingLoadingState extends DistributionCreationState {}

final class DataFetchingFailedState extends DistributionCreationState {
  const DataFetchingFailedState({required this.message});

  final String message;

  @override
  List<String> get props => [message];
}

final class DataFetchingDoneState extends DistributionCreationState {
  const DataFetchingDoneState({
    required this.products,
    required this.clients,
  });

  final List<ProductEntity> products;
  final List<ClientEntity> clients;

  @override
  List<Object> get props => [
        products,
        clients,
      ];
}

final class DistributionCreationLoadingState extends DistributionCreationState {
  const DistributionCreationLoadingState();
}

final class DistributionCreationFailedState extends DistributionCreationState {
  const DistributionCreationFailedState({required this.message});

  final String message;

  @override
  List<String> get props => [message];
}

final class DistributionCreationDoneState extends DistributionCreationState {
  const DistributionCreationDoneState();
}
