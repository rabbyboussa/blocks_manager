part of 'distributions_bloc.dart';

sealed class DistributionsState extends Equatable {
  const DistributionsState({
    this.distributions,
    this.message,
  });

  final List<DistributionEntity>? distributions;
  final String? message;

  @override
  List<Object?> get props => [
        distributions,
        message,
      ];
}

final class DitributionsInitial extends DistributionsState {}

final class DistributionsFetchingLoadingState extends DistributionsState {}

final class DistributionsFetchingFailedState extends DistributionsState {
  const DistributionsFetchingFailedState({required String message})
      : super(message: message);
}

final class DistributionsFetchingDoneState extends DistributionsState {
  const DistributionsFetchingDoneState(
      {required List<DistributionEntity> distributions})
      : super(distributions: distributions);
}
