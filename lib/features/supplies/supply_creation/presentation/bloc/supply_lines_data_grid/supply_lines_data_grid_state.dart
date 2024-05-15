part of 'supply_lines_data_grid_bloc.dart';

sealed class SupplyLinesDataGridState {
  const SupplyLinesDataGridState();
}

final class SupplyLinesDataGridInitial extends SupplyLinesDataGridState {}

final class LinesEditedState extends SupplyLinesDataGridState {
  const LinesEditedState({required this.supplyLines});

  final List<SupplyLineEntity> supplyLines;
}
