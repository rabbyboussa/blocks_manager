import 'package:equatable/equatable.dart';

class EmployeeEntity extends Equatable {
  const EmployeeEntity({
    this.id,
    required this.firstname,
    required this.lastname,
    required this.genre,
    required this.birthdate,
    this.birthplace,
    required this.nationality,
    required this.function,
    this.address,
    this.city,
    this.country,
    this.phoneNumber,
    this.email,
    this.fax,
    this.imagePath,
  });

  final int? id;
  final String firstname;
  final String lastname;
  final int genre;
  final String birthdate;
  final String? birthplace;
  final String nationality;
  final String function;
  final String? address;
  final String? city;
  final String? country;
  final String? phoneNumber;
  final String? email;
  final String? fax;
  final String? imagePath;

  EmployeeEntity copyWith({
    int? id,
    String? firstname,
    String? lastname,
    int? genre,
    String? birthdate,
    String? birthplace,
    String? nationality,
    String? function,
    String? address,
    String? city,
    String? country,
    String? phoneNumber,
    String? email,
    String? fax,
    String? imagePath,
  }) {
    return EmployeeEntity(
      id: id ?? this.id,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      genre: genre ?? this.genre,
      birthdate: birthdate ?? this.birthdate,
      birthplace: birthplace ?? this.birthplace,
      nationality: nationality ?? this.nationality,
      function: function ?? this.function,
      address: address ?? this.address,
      city: city ?? this.city,
      country: country ?? this.country,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      fax: fax ?? this.fax,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  @override
  List<Object?> get props => [
        id,
        firstname,
        lastname,
        genre,
        birthdate,
        birthplace,
        nationality,
        function,
        address,
        city,
        country,
        phoneNumber,
        email,
        fax,
        imagePath,
      ];
}
