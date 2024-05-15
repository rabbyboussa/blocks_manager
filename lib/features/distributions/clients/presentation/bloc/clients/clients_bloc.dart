import 'package:bloc/bloc.dart';
import 'package:blocks/features/distributions/clients/domain/entities/client_entity.dart';
import 'package:blocks/features/distributions/clients/domain/usecases/fetch_clients_usecase.dart';
import 'package:equatable/equatable.dart';

part 'clients_event.dart';
part 'clients_state.dart';

class ClientsBloc extends Bloc<ClientsEvent, ClientsState> {
  ClientsBloc({required FetchClientsUsecase fetchClientsUsecase})
      : _fetchClientsUsecase = fetchClientsUsecase,
        super(ClientsInitial()) {
    on<FetchClientsEvent>(onFetching);
    on<ClientAddedEvent>(onSupplierAdded);
    on<ClientUpdatedEvent>(onSupplierUpdated);
  }

  final FetchClientsUsecase _fetchClientsUsecase;

  Future<void> onSupplierAdded(
      ClientAddedEvent event, Emitter<ClientsState> emit) async {
    List<ClientEntity> clients = List<ClientEntity>.from(state.clients!);
    ClientEntity client = event.client.copyWith();
    clients.add(client);
    emit(ClientsFetchingDoneState(clients: clients));
  }

  Future<void> onSupplierUpdated(
      ClientUpdatedEvent event, Emitter<ClientsState> emit) async {
    List<ClientEntity> clients = List<ClientEntity>.from(state.clients!);
    final ClientEntity client = event.client.copyWith();
    final int index = clients.indexWhere((element) => element.id == client.id);
    clients[index] = client;
    emit(ClientsFetchingDoneState(clients: clients));
  }

  Future<void> onFetching(
      FetchClientsEvent event, Emitter<ClientsState> emit) async {
    emit(ClientsFetchingLoadingState());

    final result = await _fetchClientsUsecase();

    result.fold(
      (failure) {
        emit(ClientsFetchingFailedState(message: failure.message));
      },
      (clients) {
        emit(
          ClientsFetchingDoneState(clients: clients),
        );
      },
    );
  }
}
