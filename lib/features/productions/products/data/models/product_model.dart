import 'package:blocks/features/productions/products/domain/entities/product_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel extends ProductEntity {
  const ProductModel({
    required int id,
    required String designation,
    String? description,
    required double width,
    required double length,
    required double height,
    required double weight,
    required double unitPrice,
    required int quantity,
    String? imagePath,
  }) : super(
          id: id,
          designation: designation,
          description: description,
          width: width,
          length: length,
          height: height,
          weight: weight,
          unitPrice: unitPrice,
          quantity: quantity,
          imagePath: imagePath,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
