import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/core/usecases/usecase.dart';
import 'package:blocks/features/administration/accounts/domain/entities/role_entity.dart';
import 'package:blocks/features/administration/accounts/domain/repositories/accounts_repository.dart';

class FetchRolesUsecase
    extends UsecaseWithoutParams<ResultFuture<List<RoleEntity>>> {
  const FetchRolesUsecase({required AccountsRepository repository})
      : _repository = repository;

  final AccountsRepository _repository;

  @override
  ResultFuture<List<RoleEntity>> call() async => _repository.fetchRoles();
}
