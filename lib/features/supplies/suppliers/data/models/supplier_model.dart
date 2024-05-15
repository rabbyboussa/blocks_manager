import 'package:blocks/features/supplies/suppliers/domain/entities/supplier_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'supplier_model.g.dart';

@JsonSerializable()
class SupplierModel extends SupplierEntity {
  const SupplierModel({
    required int id,
    required String denomination,
    required String type,
    String? address,
    String? city,
    String? country,
    String? phoneNumber,
    String? email,
    String? fax,
    String? website,
    String? notes,
  }) : super(
          id: id,
          denomination: denomination,
          type: type,
          address: address,
          city: city,
          country: country,
          phoneNumber: phoneNumber,
          email: email,
          fax: fax,
          website: website,
          notes: notes,
        );

  factory SupplierModel.fromJson(Map<String, dynamic> json) =>
      _$SupplierModelFromJson(json);

  Map<String, dynamic> toJson() => _$SupplierModelToJson(this);
}
