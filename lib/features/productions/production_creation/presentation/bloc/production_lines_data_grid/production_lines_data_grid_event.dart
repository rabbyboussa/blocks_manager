part of 'production_lines_data_grid_bloc.dart';

sealed class ProductionLinesDataGridEvent {
  const ProductionLinesDataGridEvent();
}

final class LinesEditedEvent extends ProductionLinesDataGridEvent {
  const LinesEditedEvent({required this.lines});

  final List<ProductionLineEntity> lines;
}
