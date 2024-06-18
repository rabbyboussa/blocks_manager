import 'package:bloc/bloc.dart';
import 'package:blocks/features/supplies/suppliers/domain/entities/supplier_entity.dart';
import 'package:blocks/features/supplies/suppliers/domain/usecases/add_supplier_usecase.dart';
import 'package:blocks/features/supplies/suppliers/domain/usecases/update_supplier_usecase.dart';
import 'package:equatable/equatable.dart';

part 'edit_supplier_event.dart';
part 'edit_supplier_state.dart';

class EditSupplierBloc extends Bloc<EditSupplierEvent, EditSupplierState> {
  EditSupplierBloc({
    required AddSupplierUsecase addSupplierUsecase,
    required UpdateSupplierUsecase updateSupplierUsecase,
  })  : _addSupplierUsecase = addSupplierUsecase,
        _updateSupplierUsecase = updateSupplierUsecase,
        super(EditSupplierInitial()) {
    on<EditEvent>(onEditing);
  }

  final AddSupplierUsecase _addSupplierUsecase;
  final UpdateSupplierUsecase _updateSupplierUsecase;

  Future<void> onEditing(
      EditEvent event, Emitter<EditSupplierState> emit) async {
    emit(EditSupplierLoadingState());

    if (event.modification) {
      final result = await _updateSupplierUsecase(
          UpdateSupplierUsecaseParams(supplier: event.supplier));

      result.fold(
        (failure) {
          emit(EditSupplierFailedState(message: failure.message));
        },
        (_) {
          emit(
            EditSupplierDoneState(
              supplier: event.supplier,
              modification: true,
            ),
          );
        },
      );
    } else {
      final result = await _addSupplierUsecase(AddSupplierUsecaseParams(
        supplier: event.supplier,
        siteId: event.siteId,
      ));

      result.fold(
        (failure) {
          emit(EditSupplierFailedState(message: failure.message));
        },
        (supplier) {
          emit(
            EditSupplierDoneState(supplier: supplier),
          );
        },
      );
    }
  }
}
