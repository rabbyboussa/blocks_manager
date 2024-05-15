part of 'clients_bloc.dart';

sealed class ClientsEvent extends Equatable {
  const ClientsEvent();

  @override
  List<Object> get props => [];
}

final class FetchClientsEvent extends ClientsEvent {}

final class ClientAddedEvent extends ClientsEvent {
  const ClientAddedEvent({required this.client});

  final ClientEntity client;

  @override
  List<ClientEntity> get props => [client];
}

final class ClientUpdatedEvent extends ClientsEvent {
  const ClientUpdatedEvent({required this.client});

  final ClientEntity client;

  @override
  List<Object> get props => [client];
}
