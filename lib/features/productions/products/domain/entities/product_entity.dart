import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  const ProductEntity({
    this.id,
    required this.siteId,
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
  final int siteId;
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
    int? siteId,
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
      siteId: siteId ?? this.siteId,
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
        siteId,
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
