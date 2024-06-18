import 'package:equatable/equatable.dart';

class CountryEntity extends Equatable {
  const CountryEntity({
    this.id,
    required this.name,
  });

  final int? id;
  final String name;

  CountryEntity copyWith({
    int? id,
    String? name,
  }) {
    return CountryEntity(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}
