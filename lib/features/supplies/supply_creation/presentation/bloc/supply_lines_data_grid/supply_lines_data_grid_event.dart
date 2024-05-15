part of 'supply_lines_data_grid_bloc.dart';

sealed class SupplyLinesDataGridEvent {
  const SupplyLinesDataGridEvent();
}

final class LinesEditedEvent extends SupplyLinesDataGridEvent {
  const LinesEditedEvent({required this.supplyLines});

  final List<SupplyLineEntity> supplyLines;
}
