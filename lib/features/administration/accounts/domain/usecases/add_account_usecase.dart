import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/core/usecases/usecase.dart';
import 'package:blocks/features/administration/accounts/domain/entities/account_entity.dart';
import 'package:blocks/features/administration/accounts/domain/repositories/accounts_repository.dart';
import 'package:equatable/equatable.dart';

class AddAccountUsecase
    extends Usecase<ResultFuture<AccountEntity>, AddAccountUsecaseParams> {
  const AddAccountUsecase({required AccountsRepository repository})
      : _repository = repository;

  final AccountsRepository _repository;

  @override
  ResultFuture<AccountEntity> call(AddAccountUsecaseParams params) async =>
      _repository.addAccount(account: params.account);
}

class AddAccountUsecaseParams extends Equatable {
  const AddAccountUsecaseParams({required this.account});

  final AccountEntity account;

  @override
  List<AccountEntity> get props => [account];
}
