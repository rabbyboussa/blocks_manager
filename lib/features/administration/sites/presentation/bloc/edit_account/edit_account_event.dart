part of 'edit_account_bloc.dart';

sealed class EditAccountEvent extends Equatable {
  const EditAccountEvent();

  @override
  List<Object> get props => [];
}

final class EditEvent extends EditAccountEvent {
  const EditEvent({
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
