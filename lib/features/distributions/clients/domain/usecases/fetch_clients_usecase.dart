import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/core/usecases/usecase.dart';
import 'package:blocks/features/distributions/clients/domain/entities/client_entity.dart';
import 'package:blocks/features/distributions/clients/domain/repositories/clients_repository.dart';

class FetchClientsUsecase
    extends UsecaseWithoutParams<ResultFuture<List<ClientEntity>>> {
  const FetchClientsUsecase({required ClientsRepository repository})
      : _repository = repository;

  final ClientsRepository _repository;

  @override
  ResultFuture<List<ClientEntity>> call() async => _repository.fetchClients();
}
