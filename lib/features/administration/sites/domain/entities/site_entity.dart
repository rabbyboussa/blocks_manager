import 'package:equatable/equatable.dart';

class SiteEntity extends Equatable {
  const SiteEntity({
    this.id,
    required this.name,
    this.active = 1,
    this.address,
    this.city,
    required this.countryId,
    this.phoneNumber,
    this.email,
    this.fax,
    this.website,
    this.notes,
  });

  final int? id;
  final String name;
  final int active;
  final String? address;
  final String? city;
  final int countryId;
  final String? phoneNumber;
  final String? email;
  final String? fax;
  final String? website;
  final String? notes;

  SiteEntity copyWith({
    int? id,
    String? name,
    int? active,
    String? address,
    String? city,
    int? countryId,
    String? phoneNumber,
    String? email,
    String? fax,
    String? website,
    String? notes,
  }) {
    return SiteEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      active: active ?? this.active,
      address: address ?? this.address,
      city: city ?? this.city,
      countryId: countryId ?? this.countryId,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      fax: fax ?? this.fax,
      website: website ?? this.website,
      notes: notes ?? this.notes,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        active,
        address,
        city,
        countryId,
        phoneNumber,
        email,
        fax,
        website,
        notes,
      ];
}
