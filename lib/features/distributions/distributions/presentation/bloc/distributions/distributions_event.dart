part of 'distributions_bloc.dart';

sealed class DistributionsEvent extends Equatable {
  const DistributionsEvent();

  @override
  List<Object> get props => [];
}

final class FetchDistributionsEvent extends DistributionsEvent {}
