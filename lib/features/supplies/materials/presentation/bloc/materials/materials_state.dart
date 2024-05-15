part of 'materials_bloc.dart';

sealed class MaterialsState extends Equatable {
  const MaterialsState({
    this.materials,
    this.message,
  });

  final List<MaterialEntity>? materials;
  final String? message;

  @override
  List<Object?> get props => [
        materials,
        message,
      ];
}

final class ProductsInitial extends MaterialsState {}

final class MaterialsFetchingLoadingState extends MaterialsState {}

final class MaterialsFetchingFailedState extends MaterialsState {
  const MaterialsFetchingFailedState({required String message})
      : super(message: message);
}

final class MaterialsFetchingDoneState extends MaterialsState {
  const MaterialsFetchingDoneState({required List<MaterialEntity> materials})
      : super(materials: materials);
}
