import 'package:bloc/bloc.dart';
import 'package:blocks/features/supplies/supply_creation/domain/entities/supply_line_entity.dart';

part 'supply_lines_data_grid_event.dart';
part 'supply_lines_data_grid_state.dart';

class SupplyLinesDataGridBloc
    extends Bloc<SupplyLinesDataGridEvent, SupplyLinesDataGridState> {
  SupplyLinesDataGridBloc() : super(SupplyLinesDataGridInitial()) {
    on<LinesEditedEvent>(onLinesEdited);
  }

  Future<void> onLinesEdited(
      LinesEditedEvent event, Emitter<SupplyLinesDataGridState> emit) async {
    emit(LinesEditedState(supplyLines: event.supplyLines));
  }
}
