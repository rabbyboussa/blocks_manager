part of 'materials_bloc.dart';

sealed class MaterialsEvent extends Equatable {
  const MaterialsEvent();

  @override
  List<Object> get props => [];
}

final class FetchMaterialsEvent extends MaterialsEvent {
  const FetchMaterialsEvent({required this.siteId});

  final int siteId;

  @override
  List<int> get props => [siteId];
}

final class MaterialAddedEvent extends MaterialsEvent {
  const MaterialAddedEvent({required this.material});

  final MaterialEntity material;

  @override
  List<MaterialEntity> get props => [material];
}

final class MaterialUpdatedEvent extends MaterialsEvent {
  const MaterialUpdatedEvent({required this.material});

  final MaterialEntity material;

  @override
  List<Object> get props => [material];
}
