import 'package:blocks/features/administration/sites/domain/entities/site_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'site_model.g.dart';

@JsonSerializable()
class SiteModel extends SiteEntity {
  const SiteModel({
    required int id,
    required String name,
    required int active,
    String? address,
    String? city,
    required int countryId,
    String? phoneNumber,
    String? email,
    String? fax,
    String? website,
    String? notes,
  }) : super(
          id: id,
          name: name,
          active: active,
          address: address,
          city: city,
          countryId: countryId,
          phoneNumber: phoneNumber,
          email: email,
          fax: fax,
          website: website,
          notes: notes,
        );

  factory SiteModel.fromJson(Map<String, dynamic> json) =>
      _$SiteModelFromJson(json);

  Map<String, dynamic> toJson() => _$SiteModelToJson(this);
}
