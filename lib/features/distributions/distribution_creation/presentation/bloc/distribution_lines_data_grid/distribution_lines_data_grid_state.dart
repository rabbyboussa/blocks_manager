part of 'distribution_lines_data_grid_bloc.dart';

sealed class DistributionLinesDataGridState {
  const DistributionLinesDataGridState();
}

final class DistributionLinesDataGridInitial
    extends DistributionLinesDataGridState {}

final class LinesEditedState extends DistributionLinesDataGridState {
  const LinesEditedState({required this.lines});

  final List<DistributionLineEntity> lines;
}
