import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  const ProductEntity({
    this.id,
    required this.designation,
    this.description,
    required this.width,
    required this.length,
    required this.height,
    required this.weight,
    required this.unitPrice,
    this.quantity = 0,
    this.imagePath,
  });

  final int? id;
  final String designation;
  final String? description;
  final double width;
  final double length;
  final double height;
  final double weight;
  final double unitPrice;
  final int quantity;
  final String? imagePath;

  ProductEntity copyWith({
    int? id,
    String? designation,
    String? description,
    double? width,
    double? length,
    double? height,
    double? weight,
    double? unitPrice,
    int? quantity,
    String? imagePath,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      designation: designation ?? this.designation,
      description: description ?? this.description,
      width: width ?? this.width,
      length: length ?? this.length,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      unitPrice: unitPrice ?? this.unitPrice,
      quantity: quantity ?? this.quantity,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  @override
  List<Object?> get props => [
        id,
        designation,
        width,
        length,
        height,
        weight,
        description,
        unitPrice,
        quantity,
        imagePath,
      ];
}
