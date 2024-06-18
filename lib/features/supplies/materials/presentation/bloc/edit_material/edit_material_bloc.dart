import 'package:bloc/bloc.dart';
import 'package:blocks/core/constants/constants.dart';
import 'package:blocks/core/services/injection_container.dart';
import 'package:blocks/features/supplies/materials/domain/entities/material_entity.dart';
import 'package:blocks/features/supplies/materials/domain/usecases/add_material_usecase.dart';
import 'package:blocks/features/supplies/materials/domain/usecases/update_material_usecase.dart';
import 'package:equatable/equatable.dart';

part 'edit_material_event.dart';
part 'edit_material_state.dart';

class EditMaterialBloc extends Bloc<EditMaterialEvent, EditMaterialState> {
  EditMaterialBloc({
    required AddMaterialUsecase addMaterialsUsecase,
    required UpdateMaterialUsecase updateMaterialUsecase,
  })  : _addMaterialsUsecase = addMaterialsUsecase,
        _updateMaterialUsecase = updateMaterialUsecase,
        super(EditMaterialInitial()) {
    on<EditEvent>(onEditing);
  }

  final AddMaterialUsecase _addMaterialsUsecase;
  final UpdateMaterialUsecase _updateMaterialUsecase;

  Future<void> onEditing(
      EditEvent event, Emitter<EditMaterialState> emit) async {
    emit(EditMaterialLoadingState());

    try {
      String? imageUrl;

      if (event.material.imagePath != null) {
        imageUrl = await uploadImageToStorage(sl(), event.material.imagePath!);
      }

      MaterialEntity material = event.material.copyWith(imagePath: imageUrl);

      if (event.modification) {
        final result = await _updateMaterialUsecase(
            UpdateMaterialUsecaseParams(material: material));

        result.fold(
          (failure) {
            emit(EditMaterialFailedState(message: failure.message));
          },
          (_) {
            emit(
              EditMaterialDoneState(
                material: material,
                modification: true,
              ),
            );
          },
        );
      } else {
        final result = await _addMaterialsUsecase(AddMaterialUsecaseParams(
          material: material,
          siteId: event.siteId!,
        ));

        result.fold(
          (failure) {
            emit(EditMaterialFailedState(message: failure.message));
          },
          (material) {
            emit(
              EditMaterialDoneState(material: material),
            );
          },
        );
      }
    } catch (e) {
      emit(EditMaterialFailedState(message: e.toString()));
    }
  }
}
