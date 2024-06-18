import 'package:equatable/equatable.dart';

class RoleEntity extends Equatable {
  const RoleEntity({
    this.id,
    required this.name,
    this.description,
  });

  final int? id;
  final String name;
  final String? description;

  RoleEntity copyWith({
    int? id,
    String? name,
    String? description,
  }) {
    return RoleEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
      ];
}
