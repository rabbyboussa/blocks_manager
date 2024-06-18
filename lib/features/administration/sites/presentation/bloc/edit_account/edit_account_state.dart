part of 'edit_account_bloc.dart';

sealed class EditAccountState extends Equatable {
  const EditAccountState();

  @override
  List<Object> get props => [];
}

final class EditAccountInitial extends EditAccountState {}

final class EditAccountLoadingState extends EditAccountState {}

final class EditAccountFailedState extends EditAccountState {
  const EditAccountFailedState({required this.message});

  final String message;

  @override
  List<String> get props => [message];
}

final class EditAccountDoneState extends EditAccountState {
  const EditAccountDoneState({
    required this.account,
    this.modification = false,
  });

  final AccountEntity account;
  final bool modification;

  @override
  List<Object> get props => [
        account,
        modification,
      ];
}
