part of 'distribution_lines_data_grid_bloc.dart';

sealed class DistributionLinesDataGridEvent {
  const DistributionLinesDataGridEvent();
}

final class LinesEditedEvent extends DistributionLinesDataGridEvent {
  const LinesEditedEvent({required this.lines});

  final List<DistributionLineEntity> lines;
}
