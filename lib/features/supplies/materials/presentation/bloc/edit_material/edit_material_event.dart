part of 'edit_material_bloc.dart';

sealed class EditMaterialEvent extends Equatable {
  const EditMaterialEvent();

  @override
  List<Object?> get props => [];
}

final class EditEvent extends EditMaterialEvent {
  const EditEvent({
    required this.material,
    this.siteId,
    this.modification = false,
  });

  final MaterialEntity material;
  final int? siteId;
  final bool modification;

  @override
  List<Object?> get props => [
        material,
        siteId,
        modification,
      ];
}
