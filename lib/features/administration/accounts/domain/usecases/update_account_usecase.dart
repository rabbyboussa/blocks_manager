import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/core/usecases/usecase.dart';
import 'package:blocks/features/administration/accounts/domain/entities/account_entity.dart';
import 'package:blocks/features/administration/accounts/domain/repositories/accounts_repository.dart';
import 'package:equatable/equatable.dart';

class UpdateAccountUsecase
    extends Usecase<ResultFutureVoid, UpdateAccountUsecaseParams> {
  const UpdateAccountUsecase({required AccountsRepository repository})
      : _repository = repository;

  final AccountsRepository _repository;

  @override
  ResultFutureVoid call(UpdateAccountUsecaseParams params) async =>
      _repository.updateAccount(account: params.account);
}

class UpdateAccountUsecaseParams extends Equatable {
  const UpdateAccountUsecaseParams({required this.account});

  final AccountEntity account;

  @override
  List<AccountEntity> get props => [account];
}
