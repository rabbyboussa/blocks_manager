part of 'supply_details_bloc.dart';

sealed class SupplyDetailsState extends Equatable {
  const SupplyDetailsState({
    this.lines,
    this.message,
  });

  final List<SupplyLineEntity>? lines;
  final String? message;

  @override
  List<Object?> get props => [
        lines,
        message,
      ];
}

final class ProductsInitial extends SupplyDetailsState {}

final class SupplyDetailsFetchingLoadingState extends SupplyDetailsState {}

final class SupplyDetailsFetchingFailedState extends SupplyDetailsState {
  const SupplyDetailsFetchingFailedState({required String message})
      : super(message: message);
}

final class SupplyDetailsFetchingDoneState extends SupplyDetailsState {
  const SupplyDetailsFetchingDoneState({required List<SupplyLineEntity> lines})
      : super(lines: lines);
}
