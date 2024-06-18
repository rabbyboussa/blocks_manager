import 'package:bloc/bloc.dart';
import 'package:blocks/features/administration/sites/domain/entities/site_entity.dart';
import 'package:blocks/features/administration/sites/domain/usecases/add_site_usecase.dart';
import 'package:blocks/features/administration/sites/domain/usecases/update_site_usecase.dart';
import 'package:equatable/equatable.dart';

part 'edit_site_event.dart';
part 'edit_site_state.dart';

class EditSiteBloc extends Bloc<EditSiteEvent, EditSiteState> {
  EditSiteBloc({
    required AddSiteUsecase addSiteUsecase,
    required UpdateSiteUsecase updateSiteUsecase,
  })  : _addSiteUsecase = addSiteUsecase,
        _updateSiteUsecase = updateSiteUsecase,
        super(EditsiteInitial()) {
    on<EditEvent>(onEditing);
  }

  final AddSiteUsecase _addSiteUsecase;
  final UpdateSiteUsecase _updateSiteUsecase;

  Future<void> onEditing(EditEvent event, Emitter<EditSiteState> emit) async {
    emit(EditSiteLoadingState());

    if (event.modification) {
      final result =
          await _updateSiteUsecase(UpdateSiteUsecaseParams(site: event.site));

      result.fold(
        (failure) {
          emit(EditSiteFailedState(message: failure.message));
        },
        (_) {
          emit(
            EditSiteDoneState(
              site: event.site,
              modification: true,
            ),
          );
        },
      );
    } else {
      final result =
          await _addSiteUsecase(AddSiteUsecaseParams(site: event.site));

      result.fold(
        (failure) {
          emit(EditSiteFailedState(message: failure.message));
        },
        (site) {
          emit(
            EditSiteDoneState(site: site),
          );
        },
      );
    }
  }
}
