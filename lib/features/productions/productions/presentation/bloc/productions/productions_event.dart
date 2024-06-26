part of 'productions_bloc.dart';

sealed class ProductionsEvent extends Equatable {
  const ProductionsEvent();

  @override
  List<Object> get props => [];
}

final class FetchProductionsEvent extends ProductionsEvent {
  const FetchProductionsEvent({required this.siteId});

  final int siteId;

  @override
  List<Object> get props => [siteId];
}
