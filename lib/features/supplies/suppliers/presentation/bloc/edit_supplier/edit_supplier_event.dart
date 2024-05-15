part of 'edit_supplier_bloc.dart';

sealed class EditSupplierEvent extends Equatable {
  const EditSupplierEvent();

  @override
  List<Object> get props => [];
}

final class EditEvent extends EditSupplierEvent {
  const EditEvent({
    required this.supplier,
    this.modification = false,
  });

  final SupplierEntity supplier;
  final bool modification;

  @override
  List<Object> get props => [
        supplier,
        modification,
      ];
}
