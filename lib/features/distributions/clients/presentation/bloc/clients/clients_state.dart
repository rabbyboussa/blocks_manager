part of 'clients_bloc.dart';

sealed class ClientsState extends Equatable {
  const ClientsState({
    this.clients,
    this.message,
  });

  final List<ClientEntity>? clients;
  final String? message;

  @override
  List<Object?> get props => [
        clients,
        message,
      ];
}

final class ClientsInitial extends ClientsState {}

final class ClientsFetchingLoadingState extends ClientsState {}

final class ClientsFetchingFailedState extends ClientsState {
  const ClientsFetchingFailedState({required String message})
      : super(message: message);
}

final class ClientsFetchingDoneState extends ClientsState {
  const ClientsFetchingDoneState({required List<ClientEntity> clients})
      : super(clients: clients);
}
