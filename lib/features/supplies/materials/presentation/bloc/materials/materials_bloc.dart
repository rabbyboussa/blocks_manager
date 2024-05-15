import 'package:bloc/bloc.dart';
import 'package:blocks/features/supplies/materials/domain/entities/material_entity.dart';
import 'package:blocks/features/supplies/materials/domain/usecases/fetch_materials_usecase.dart';
import 'package:equatable/equatable.dart';

part 'materials_event.dart';
part 'materials_state.dart';

class MaterialsBloc extends Bloc<MaterialsEvent, MaterialsState> {
  MaterialsBloc({required FetchMaterialsUsecase fetchMaterialsUsecase})
      : _fetchMaterialsUsecase = fetchMaterialsUsecase,
        super(ProductsInitial()) {
    on<FetchMaterialsEvent>(onFetching);
    on<MaterialAddedEvent>(onMaterialAdded);
    on<MaterialUpdatedEvent>(onMaterialUpdated);
  }

  final FetchMaterialsUsecase _fetchMaterialsUsecase;

  Future<void> onMaterialAdded(
      MaterialAddedEvent event, Emitter<MaterialsState> emit) async {
    List<MaterialEntity> materials =
        List<MaterialEntity>.from(state.materials!);
    MaterialEntity material = event.material.copyWith();
    materials.add(material);
    emit(MaterialsFetchingDoneState(materials: materials));
  }

  Future<void> onMaterialUpdated(
      MaterialUpdatedEvent event, Emitter<MaterialsState> emit) async {
    List<MaterialEntity> materials =
        List<MaterialEntity>.from(state.materials!);
    final MaterialEntity material = event.material.copyWith();
    final int index =
        materials.indexWhere((element) => element.id == material.id);
    materials[index] = material;
    emit(MaterialsFetchingDoneState(materials: materials));
  }

  Future<void> onFetching(
      FetchMaterialsEvent event, Emitter<MaterialsState> emit) async {
    emit(MaterialsFetchingLoadingState());

    final result = await _fetchMaterialsUsecase();

    result.fold(
      (failure) {
        emit(MaterialsFetchingFailedState(message: failure.message));
      },
      (materials) {
        emit(
          MaterialsFetchingDoneState(materials: materials),
        );
      },
    );
  }
}
