import 'package:bloc/bloc.dart';
import 'package:blocks/core/constants/constants.dart';
import 'package:blocks/core/services/injection_container.dart';
import 'package:blocks/features/productions/products/domain/entities/product_entity.dart';
import 'package:blocks/features/productions/products/domain/usecases/add_product_usecase.dart';
import 'package:blocks/features/productions/products/domain/usecases/update_product_usecase.dart';
import 'package:equatable/equatable.dart';

part 'edit_product_event.dart';
part 'edit_product_state.dart';

class EditProductBloc extends Bloc<EditProductEvent, EditProductState> {
  EditProductBloc({
    required AddProductUsecase addProductUsecase,
    required UpdateProductUsecase updateProductUsecase,
  })  : _addProductUsecase = addProductUsecase,
        _updateProductUsecase = updateProductUsecase,
        super(EditProductInitial()) {
    on<EditEvent>(onEditing);
  }

  final AddProductUsecase _addProductUsecase;
  final UpdateProductUsecase _updateProductUsecase;

  Future<void> onEditing(
      EditEvent event, Emitter<EditProductState> emit) async {
    emit(EditProductLoadingState());

    try {
      String? imageUrl;

      if (event.product.imagePath != null) {
        imageUrl = await uploadImageToStorage(sl(), event.product.imagePath!);
      }

      ProductEntity product = event.product.copyWith(imagePath: imageUrl);

      if (event.modification) {
        final result = await _updateProductUsecase(
            UpdateProductUsecaseParams(product: product));

        result.fold(
          (failure) {
            emit(EditProductFailedState(message: failure.message));
          },
          (_) {
            emit(
              EditProductDoneState(
                product: product,
                modification: true,
              ),
            );
          },
        );
      } else {
        final result = await _addProductUsecase(AddProductUsecaseParams(
          product: product,
          siteId: event.siteId,
        ));

        result.fold(
          (failure) {
            emit(EditProductFailedState(message: failure.message));
          },
          (product) {
            emit(
              EditProductDoneState(product: product),
            );
          },
        );
      }
    } catch (e) {
      emit(EditProductFailedState(message: e.toString()));
    }
  }
}
