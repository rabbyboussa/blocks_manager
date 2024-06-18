import 'package:equatable/equatable.dart';

class MaterialEntity extends Equatable {
  const MaterialEntity({
    this.id,
    required this.siteId,
    required this.designation,
    this.description,
    required this.measurementUnit,
    this.quantity = 0,
    this.imagePath,
  });

  final int? id;
  final int siteId;
  final String designation;
  final String? description;
  final String measurementUnit;
  final int quantity;
  final String? imagePath;

  MaterialEntity copyWith({
    int? id,
    int? siteId,
    String? designation,
    String? description,
    String? measurementUnit,
    int? quantity,
    String? imagePath,
  }) {
    return MaterialEntity(
      id: id ?? this.id,
      siteId: siteId ?? this.siteId,
      designation: designation ?? this.designation,
      description: description ?? this.description,
      measurementUnit: measurementUnit ?? this.measurementUnit,
      quantity: quantity ?? this.quantity,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  @override
  List<Object?> get props => [
        id,
        siteId,
        designation,
        description,
        measurementUnit,
        quantity,
        imagePath,
      ];
}
