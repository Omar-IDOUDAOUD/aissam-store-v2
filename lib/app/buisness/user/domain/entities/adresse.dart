import 'package:equatable/equatable.dart';

class Address extends Equatable{
  final String id;
  final String? address;
  final String? city;
  final String? country;
  final String? region;
  final String? createdAt;
  final String? updatedAt;

  const Address({
    required this.id,
    this.city,
    this.address,
    this.country,
    this.region,
    this.createdAt,
    this.updatedAt,
  });
  
  @override
  List<Object?> get props => [id, address, city, country, region, createdAt, updatedAt];
}
