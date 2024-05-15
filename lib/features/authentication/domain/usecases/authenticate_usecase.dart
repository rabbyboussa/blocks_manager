import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/core/usecases/usecase.dart';
import 'package:blocks/features/administration/accounts/domain/entities/account_entity.dart';
import 'package:blocks/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:equatable/equatable.dart';

class AuthenticateUsecase
    extends Usecase<ResultFuture<AccountEntity?>, AuthenticationParams> {
  const AuthenticateUsecase({required AuthenticationRepository repository})
      : _repository = repository;

  final AuthenticationRepository _repository;

  @override
  ResultFuture<AccountEntity?> call(AuthenticationParams params) async =>
      _repository.authenticate(
        username: params.username,
        password: params.password,
      );
}

class AuthenticationParams extends Equatable {
  const AuthenticationParams({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;

  @override
  List<Object?> get props => [
        username,
        password,
      ];
}
