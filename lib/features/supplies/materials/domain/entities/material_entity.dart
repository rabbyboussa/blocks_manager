import 'package:equatable/equatable.dart';

class MaterialEntity extends Equatable {
  const MaterialEntity({
    this.id,
    required this.designation,
    this.description,
    required this.measurementUnit,
    this.quantity = 0,
    this.imagePath,
  });

  final int? id;
  final String designation;
  final String? description;
  final String measurementUnit;
  final int quantity;
  final String? imagePath;

  MaterialEntity copyWith({
    int? id,
    String? designation,
    String? description,
    String? measurementUnit,
    int? quantity,
    String? imagePath,
  }) {
    return MaterialEntity(
      id: id ?? this.id,
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
        designation,
        description,
        measurementUnit,
        quantity,
      ];
}
