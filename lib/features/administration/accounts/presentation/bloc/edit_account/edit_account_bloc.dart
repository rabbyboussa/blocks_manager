import 'package:bloc/bloc.dart';
import 'package:blocks/features/administration/accounts/domain/entities/account_entity.dart';
import 'package:blocks/features/administration/accounts/domain/usecases/add_account_usecase.dart';
import 'package:blocks/features/administration/accounts/domain/usecases/update_account_usecase.dart';
import 'package:equatable/equatable.dart';

part 'edit_account_event.dart';
part 'edit_account_state.dart';

class EditAccountBloc extends Bloc<EditAccountEvent, EditAccountState> {
  EditAccountBloc({
    required AddAccountUsecase addAccountUsecase,
    required UpdateAccountUsecase updateAccountUsecase,
  })  : _addAccountUsecase = addAccountUsecase,
        _updateAccountUsecase = updateAccountUsecase,
        super(EditAccountInitial()) {
    on<EditEvent>(onEditing);
  }

  final AddAccountUsecase _addAccountUsecase;
  final UpdateAccountUsecase _updateAccountUsecase;

  Future<void> onEditing(
      EditEvent event, Emitter<EditAccountState> emit) async {
    emit(EditAccountLoadingState());

    if (event.modification) {
      final result = await _updateAccountUsecase(
          UpdateAccountUsecaseParams(account: event.account));

      result.fold(
        (failure) {
          emit(EditAccountFailedState(message: failure.message));
        },
        (_) {
          emit(
            EditAccountDoneState(
              account: event.account,
              modification: true,
            ),
          );
        },
      );
    } else {
      final result = await _addAccountUsecase(
          AddAccountUsecaseParams(account: event.account));

      result.fold(
        (failure) {
          emit(EditAccountFailedState(message: failure.message));
        },
        (account) {
          emit(
            EditAccountDoneState(account: account),
          );
        },
      );
    }
  }
}
