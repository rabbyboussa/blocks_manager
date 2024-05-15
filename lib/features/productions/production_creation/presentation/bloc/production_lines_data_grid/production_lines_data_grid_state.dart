part of 'production_lines_data_grid_bloc.dart';

sealed class ProductionLinesDataGridState {
  const ProductionLinesDataGridState();
}

final class ProductionLinesDataGridInitial
    extends ProductionLinesDataGridState {}

final class LinesEditedState extends ProductionLinesDataGridState {
  const LinesEditedState({required this.lines});

  final List<ProductionLineEntity> lines;
}
