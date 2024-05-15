import 'package:bloc/bloc.dart';
import 'package:blocks/features/productions/production_creation/domain/entities/material_used_line_entity.dart';

part 'materials_used_lines_data_grid_event.dart';
part 'materials_used_lines_data_grid_state.dart';

class MaterialsUsedLinesDataGridBloc extends Bloc<
    MaterialsUsedLinesDataGridEvent, MaterialsUsedLinesDataGridState> {
  MaterialsUsedLinesDataGridBloc()
      : super(MaterialsUsedLinesDataGridInitial()) {
    on<LinesEditedEvent>(onLinesEdited);
  }

  Future<void> onLinesEdited(LinesEditedEvent event,
      Emitter<MaterialsUsedLinesDataGridState> emit) async {
    emit(LinesEditedState(lines: event.lines));
  }
}
