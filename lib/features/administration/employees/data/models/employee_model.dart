import 'package:blocks/features/administration/employees/domain/entities/employee_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'employee_model.g.dart';

@JsonSerializable()
class EmployeeModel extends EmployeeEntity {
  const EmployeeModel({
    required int id,
    required String firstname,
    required String lastname,
    required int genre,
    required String birthdate,
    String? birthplace,
    required String nationality,
    required String function,
    String? address,
    String? city,
    String? country,
    String? phoneNumber,
    String? email,
    String? fax,
    String? imagePath,
  }) : super(
          id: id,
          firstname: firstname,
          lastname: lastname,
          genre: genre,
          birthdate: birthdate,
          birthplace: birthplace,
          nationality: nationality,
          function: function,
          address: address,
          city: city,
          country: country,
          phoneNumber: phoneNumber,
          email: email,
          fax: fax,
          imagePath: imagePath,
        );

  factory EmployeeModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeModelToJson(this);
}
