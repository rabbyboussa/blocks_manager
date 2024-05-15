part of 'edit_client_bloc.dart';

sealed class EditClientState extends Equatable {
  const EditClientState();

  @override
  List<Object> get props => [];
}

final class EditClientInitial extends EditClientState {}

final class EditClientLoadingState extends EditClientState {}

final class EditClientFailedState extends EditClientState {
  const EditClientFailedState({required this.message});

  final String message;

  @override
  List<String> get props => [message];
}

final class EditClientDoneState extends EditClientState {
  const EditClientDoneState({
    required this.client,
    this.modification = false,
  });

  final ClientEntity client;
  final bool modification;

  @override
  List<Object> get props => [
        client,
        modification,
      ];
}
