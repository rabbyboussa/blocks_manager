import 'package:equatable/equatable.dart';

class SupplierEntity extends Equatable {
  const SupplierEntity({
    this.id,
    required this.denomination,
    required this.type,
    this.address,
    this.city,
    this.country,
    this.phoneNumber,
    this.email,
    this.fax,
    this.website,
    this.notes,
  });

  final int? id;
  final String denomination;
  final String type;
  final String? address;
  final String? city;
  final String? country;
  final String? phoneNumber;
  final String? email;
  final String? fax;
  final String? website;
  final String? notes;

  SupplierEntity copyWith({
    int? id,
    String? denomination,
    String? type,
    String? address,
    String? city,
    String? country,
    String? phoneNumber,
    String? email,
    String? fax,
    String? website,
    String? notes,
  }) {
    return SupplierEntity(
      id: id ?? this.id,
      denomination: denomination ?? this.denomination,
      type: type ?? this.type,
      address: address ?? this.address,
      city: city ?? this.city,
      country: country ?? this.country,
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
        denomination,
        type,
        address,
        city,
        country,
        phoneNumber,
        email,
        fax,
        website,
        notes,
      ];
}
