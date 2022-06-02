import 'package:json_annotation/json_annotation.dart';

part 'address_model.g.dart';

@JsonSerializable()
class Address {
  String addressLine1;
  String addressLine2;
  String? addressLine3;
  String? addressLine4;
  String zipCode;
  String city;
  String countryCode;

  Address(
      {required this.addressLine1,
      required this.addressLine2,
      this.addressLine3,
      this.addressLine4,
      required this.zipCode,
      required this.city,
      required this.countryCode});

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);

  void getJson(dynamic json) {
    _$AddressFromJson(json);
  }
}


//have json for request and state--?different