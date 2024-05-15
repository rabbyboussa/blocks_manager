part of 'distribution_details_bloc.dart';

sealed class DistributionDetailsState extends Equatable {
  const DistributionDetailsState({
    this.lines,
    this.message,
  });

  final List<DistributionLineEntity>? lines;
  final String? message;

  @override
  List<Object?> get props => [
        lines,
        message,
      ];
}

final class DistributionDetailsInitial extends DistributionDetailsState {}

final class DistributionDetailsFetchingLoadingState
    extends DistributionDetailsState {}

final class DistributionDetailsFetchingFailedState
    extends DistributionDetailsState {
  const DistributionDetailsFetchingFailedState({required String message})
      : super(message: message);
}

final class DistributionDetailsFetchingDoneState
    extends DistributionDetailsState {
  const DistributionDetailsFetchingDoneState(
      {required List<DistributionLineEntity> lines})
      : super(lines: lines);
}
