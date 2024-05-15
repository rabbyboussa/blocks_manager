import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/features/administration/accounts/domain/entities/account_entity.dart';
import 'package:blocks/features/administration/accounts/domain/entities/role_entity.dart';

abstract class AccountsRepository {
  const AccountsRepository();

  ResultFuture<List<RoleEntity>> fetchRoles();
  ResultFuture<List<AccountEntity>> fetchAccounts();

  ResultFuture<AccountEntity> addAccount({required AccountEntity account});

  ResultFutureVoid updateAccount({required AccountEntity account});
}
