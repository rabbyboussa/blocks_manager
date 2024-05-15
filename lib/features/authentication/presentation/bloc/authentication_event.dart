part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

final class AuthenticateEvent extends AuthenticationEvent {
  const AuthenticateEvent({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;
}

final class FetchDataEvent extends AuthenticationEvent {}
