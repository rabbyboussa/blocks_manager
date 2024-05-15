part of 'materials_used_lines_data_grid_bloc.dart';

sealed class MaterialsUsedLinesDataGridEvent {
  const MaterialsUsedLinesDataGridEvent();
}

final class LinesEditedEvent extends MaterialsUsedLinesDataGridEvent {
  const LinesEditedEvent({required this.lines});

  final List<MaterialUsedLineEntity> lines;
}
