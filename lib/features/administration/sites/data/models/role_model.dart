import 'package:blocks/features/administration/accounts/domain/entities/role_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'role_model.g.dart';

@JsonSerializable()
class RoleModel extends RoleEntity {
  const RoleModel({
    required int id,
    required String name,
    required String description,
  }) : super(
          id: id,
          name: name,
          description: description,
        );

  factory RoleModel.fromJson(Map<String, dynamic> json) =>
      _$RoleModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoleModelToJson(this);
}
