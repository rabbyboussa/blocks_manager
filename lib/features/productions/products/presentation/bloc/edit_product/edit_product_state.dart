part of 'edit_product_bloc.dart';

sealed class EditProductState extends Equatable {
  const EditProductState();

  @override
  List<Object> get props => [];
}

final class EditProductInitial extends EditProductState {}

final class EditProductLoadingState extends EditProductState {}

final class EditProductFailedState extends EditProductState {
  const EditProductFailedState({required this.message});

  final String message;

  @override
  List<String> get props => [message];
}

final class EditProductDoneState extends EditProductState {
  const EditProductDoneState({
    required this.product,
    this.modification = false,
  });

  final ProductEntity product;
  final bool modification;

  @override
  List<Object> get props => [
        product,
        modification,
      ];
}
