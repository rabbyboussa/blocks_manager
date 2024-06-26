part of 'distributions_bloc.dart';

sealed class DistributionsEvent extends Equatable {
  const DistributionsEvent();

  @override
  List<Object> get props => [];
}

final class FetchDistributionsEvent extends DistributionsEvent {
  const FetchDistributionsEvent({required this.siteId});

  final int siteId;

  @override
  List<Object> get props => [siteId];
}
