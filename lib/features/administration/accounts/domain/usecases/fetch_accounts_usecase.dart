import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/core/usecases/usecase.dart';
import 'package:blocks/features/administration/accounts/domain/entities/account_entity.dart';
import 'package:blocks/features/administration/accounts/domain/repositories/accounts_repository.dart';

class FetchAccountsUsecase
    extends UsecaseWithoutParams<ResultFuture<List<AccountEntity>>> {
  const FetchAccountsUsecase({required AccountsRepository repository})
      : _repository = repository;

  final AccountsRepository _repository;

  @override
  ResultFuture<List<AccountEntity>> call() async => _repository.fetchAccounts();
}
