part of 'materials_used_lines_data_grid_bloc.dart';

sealed class MaterialsUsedLinesDataGridState {
  const MaterialsUsedLinesDataGridState();
}

final class MaterialsUsedLinesDataGridInitial
    extends MaterialsUsedLinesDataGridState {}

final class LinesEditedState extends MaterialsUsedLinesDataGridState {
  const LinesEditedState({required this.lines});

  final List<MaterialUsedLineEntity> lines;
}
