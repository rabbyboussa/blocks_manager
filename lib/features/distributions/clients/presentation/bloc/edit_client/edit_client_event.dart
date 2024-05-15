part of 'edit_client_bloc.dart';

sealed class EditClientEvent extends Equatable {
  const EditClientEvent();

  @override
  List<Object> get props => [];
}

final class EditEvent extends EditClientEvent {
  const EditEvent({
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
