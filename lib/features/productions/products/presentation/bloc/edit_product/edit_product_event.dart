part of 'edit_product_bloc.dart';

sealed class EditProductEvent extends Equatable {
  const EditProductEvent();

  @override
  List<Object> get props => [];
}

final class EditEvent extends EditProductEvent {
  const EditEvent({
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
