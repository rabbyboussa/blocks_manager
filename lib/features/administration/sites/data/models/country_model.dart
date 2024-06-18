import 'package:blocks/features/administration/sites/domain/entities/country_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'country_model.g.dart';

@JsonSerializable()
class CountryModel extends CountryEntity {
  const CountryModel({
    required int id,
    required String name,
  }) : super(
          id: id,
          name: name,
        );

  factory CountryModel.fromJson(Map<String, dynamic> json) =>
      _$CountryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CountryModelToJson(this);
}
