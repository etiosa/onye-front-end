// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      addressLine1: json['addressLine1'] as String,
      addressLine2: json['addressLine2'] as String,
      addressLine3: json['addressLine3'] as String?,
      addressLine4: json['addressLine4'] as String?,
      zipCode: json['zipCode'] as String,
      city: json['city'] as String,
      countryCode: json['countryCode'] as String,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'addressLine1': instance.addressLine1,
      'addressLine2': instance.addressLine2,
      'addressLine3': instance.addressLine3,
      'addressLine4': instance.addressLine4,
      'zipCode': instance.zipCode,
      'city': instance.city,
      'countryCode': instance.countryCode,
    };
