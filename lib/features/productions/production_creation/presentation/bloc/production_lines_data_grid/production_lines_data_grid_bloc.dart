import 'package:bloc/bloc.dart';
import 'package:blocks/features/productions/production_creation/domain/entities/production_line_entity.dart';

part 'production_lines_data_grid_event.dart';
part 'production_lines_data_grid_state.dart';

class ProductionLinesDataGridBloc
    extends Bloc<ProductionLinesDataGridEvent, ProductionLinesDataGridState> {
  ProductionLinesDataGridBloc() : super(ProductionLinesDataGridInitial()) {
    on<LinesEditedEvent>(onLinesEdited);
  }

  Future<void> onLinesEdited(LinesEditedEvent event,
      Emitter<ProductionLinesDataGridState> emit) async {
    emit(LinesEditedState(lines: event.lines));
  }
}
