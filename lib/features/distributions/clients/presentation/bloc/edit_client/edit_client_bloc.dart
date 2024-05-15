import 'package:bloc/bloc.dart';
import 'package:blocks/features/distributions/clients/domain/entities/client_entity.dart';
import 'package:blocks/features/distributions/clients/domain/usecases/add_client_usecase.dart';
import 'package:blocks/features/distributions/clients/domain/usecases/update_client_usecase.dart';
import 'package:equatable/equatable.dart';

part 'edit_client_event.dart';
part 'edit_client_state.dart';

class EditClientBloc extends Bloc<EditClientEvent, EditClientState> {
  EditClientBloc({
    required AddClientUsecase addClientUsecase,
    required UpdateClientUsecase updateClientUsecase,
  })  : _addClientUsecase = addClientUsecase,
        _updateClientUsecase = updateClientUsecase,
        super(EditClientInitial()) {
    on<EditEvent>(onEditing);
  }

  final AddClientUsecase _addClientUsecase;
  final UpdateClientUsecase _updateClientUsecase;

  Future<void> onEditing(EditEvent event, Emitter<EditClientState> emit) async {
    emit(EditClientLoadingState());

    if (event.modification) {
      final result = await _updateClientUsecase(
          UpdateClientUsecaseParams(client: event.client));

      result.fold(
        (failure) {
          emit(EditClientFailedState(message: failure.message));
        },
        (_) {
          emit(
            EditClientDoneState(
              client: event.client,
              modification: true,
            ),
          );
        },
      );
    } else {
      final result =
          await _addClientUsecase(AddClientUsecaseParams(client: event.client));

      result.fold(
        (failure) {
          emit(EditClientFailedState(message: failure.message));
        },
        (client) {
          emit(
            EditClientDoneState(client: client),
          );
        },
      );
    }
  }
}
