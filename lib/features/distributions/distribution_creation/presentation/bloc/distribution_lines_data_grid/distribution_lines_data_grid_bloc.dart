import 'package:bloc/bloc.dart';
import 'package:blocks/features/distributions/distribution_creation/domain/entities/distribution_line_entity.dart';

part 'distribution_lines_data_grid_event.dart';
part 'distribution_lines_data_grid_state.dart';

class DistributionLinesDataGridBloc extends Bloc<DistributionLinesDataGridEvent,
    DistributionLinesDataGridState> {
  DistributionLinesDataGridBloc() : super(DistributionLinesDataGridInitial()) {
    on<LinesEditedEvent>(onLinesEdited);
  }

  Future<void> onLinesEdited(LinesEditedEvent event,
      Emitter<DistributionLinesDataGridState> emit) async {
    emit(LinesEditedState(lines: event.lines));
  }
}
