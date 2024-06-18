part of 'accounts_bloc.dart';

sealed class AccountsEvent extends Equatable {
  const AccountsEvent();

  @override
  List<Object> get props => [];
}

final class FetchAccountsEvent extends AccountsEvent {
  const FetchAccountsEvent({required this.siteId});

  final int siteId;

  @override
  List<Object> get props => [siteId];
}

final class AccountAddedEvent extends AccountsEvent {
  const AccountAddedEvent({required this.account});

  final AccountEntity account;

  @override
  List<AccountEntity> get props => [account];
}

final class AccountUpdatedEvent extends AccountsEvent {
  const AccountUpdatedEvent({required this.account});

  final AccountEntity account;

  @override
  List<AccountEntity> get props => [account];
}
