import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/core/usecases/usecase.dart';
import 'package:blocks/features/distributions/clients/domain/entities/client_entity.dart';
import 'package:blocks/features/distributions/clients/domain/repositories/clients_repository.dart';
import 'package:equatable/equatable.dart';

class AddClientUsecase
    extends Usecase<ResultFuture<ClientEntity>, AddClientUsecaseParams> {
  const AddClientUsecase({required ClientsRepository repository})
      : _repository = repository;

  final ClientsRepository _repository;

  @override
  ResultFuture<ClientEntity> call(AddClientUsecaseParams params) async =>
      _repository.addClient(client: params.client);
}

class AddClientUsecaseParams extends Equatable {
  const AddClientUsecaseParams({required this.client});

  final ClientEntity client;

  @override
  List<Object?> get props => [client];
}
