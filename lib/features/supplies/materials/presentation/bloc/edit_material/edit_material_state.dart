part of 'edit_material_bloc.dart';

sealed class EditMaterialState extends Equatable {
  const EditMaterialState();

  @override
  List<Object> get props => [];
}

final class EditMaterialInitial extends EditMaterialState {}

final class EditMaterialLoadingState extends EditMaterialState {}

final class EditMaterialFailedState extends EditMaterialState {
  const EditMaterialFailedState({required this.message});

  final String message;

  @override
  List<String> get props => [message];
}

final class EditMaterialDoneState extends EditMaterialState {
  const EditMaterialDoneState({
    required this.material,
    this.modification = false,
  });

  final MaterialEntity material;
  final bool modification;

  @override
  List<Object> get props => [
        material,
        modification,
      ];
}
