import 'package:flutter/material.dart';

class DeliveryAddress {
  final String id;
  final String title;
  final String recipient;
  final String streetLine;
  final String districtLine;
  final String zipCode;
  final IconData icon;
  final bool isDefault;

  const DeliveryAddress({
    required this.id,
    required this.title,
    required this.recipient,
    required this.streetLine,
    required this.districtLine,
    required this.zipCode,
    required this.icon,
    this.isDefault = false,
  });

  String get formattedLines =>
      '$streetLine\n$districtLine\nCEP: $zipCode';

  String get singleLineAddress => '$streetLine, $districtLine, CEP: $zipCode';
}
