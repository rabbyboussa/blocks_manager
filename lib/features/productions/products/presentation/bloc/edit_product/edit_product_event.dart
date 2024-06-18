part of 'edit_product_bloc.dart';

sealed class EditProductEvent extends Equatable {
  const EditProductEvent();

  @override
  List<Object> get props => [];
}

final class EditEvent extends EditProductEvent {
  const EditEvent({
    required this.product,
    required this.siteId,
    this.modification = false,
  });

  final ProductEntity product;
  final int siteId;
  final bool modification;

  @override
  List<Object> get props => [
        product,
        siteId,
        modification,
      ];
}
