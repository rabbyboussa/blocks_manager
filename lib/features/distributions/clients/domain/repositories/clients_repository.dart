import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/features/distributions/clients/domain/entities/client_entity.dart';

abstract class ClientsRepository {
  const ClientsRepository();

  ResultFuture<List<ClientEntity>> fetchClients();

  ResultFuture<ClientEntity> addClient({required ClientEntity client});
  ResultFutureVoid updateClient({required ClientEntity client});
}
