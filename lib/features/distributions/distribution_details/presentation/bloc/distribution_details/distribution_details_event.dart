part of 'distribution_details_bloc.dart';

sealed class DistributionDetailsEvent extends Equatable {
  const DistributionDetailsEvent();

  @override
  List<Object> get props => [];
}

final class FetchDistributionDetailsEvent extends DistributionDetailsEvent {
  const FetchDistributionDetailsEvent({required this.distributionId});

  final int distributionId;

  @override
  List<int> get props => [distributionId];
}
