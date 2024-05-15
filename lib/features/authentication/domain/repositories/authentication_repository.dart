import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/features/administration/accounts/domain/entities/account_entity.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  ResultFuture<AccountEntity?> authenticate({
    required String username,
    required String password,
  });
}
