import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/core/usecases/usecase.dart';
import 'package:blocks/features/distributions/clients/domain/entities/client_entity.dart';
import 'package:blocks/features/distributions/clients/domain/repositories/clients_repository.dart';
import 'package:equatable/equatable.dart';

class UpdateClientUsecase
    extends Usecase<ResultFutureVoid, UpdateClientUsecaseParams> {
  const UpdateClientUsecase({required ClientsRepository repository})
      : _repository = repository;

  final ClientsRepository _repository;

  @override
  ResultFutureVoid call(UpdateClientUsecaseParams params) async =>
      _repository.updateClient(client: params.client);
}

class UpdateClientUsecaseParams extends Equatable {
  const UpdateClientUsecaseParams({required this.client});

  final ClientEntity client;

  @override
  List<Object> get props => [client];
}
