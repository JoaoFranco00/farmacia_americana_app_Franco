import 'package:flutter/material.dart';

class AddressesViewModel extends ChangeNotifier {
  final List<DeliveryAddress> _addresses = const [
    DeliveryAddress(
      id: 'home-main',
      title: 'Principal (Casa)',
      recipient: 'Ricardo Oliveira',
      streetLine: 'Avenida Paulista, 1000 - Apto 42',
      districtLine: 'Bela Vista, S\u00e3o Paulo - SP',
      zipCode: '01310-100',
      icon: Icons.home_rounded,
      isDefault: true,
    ),
    DeliveryAddress(
      id: 'work',
      title: 'Trabalho',
      recipient: 'Ricardo Oliveira',
      streetLine: 'Rua das Olimp\u00edadas, 205 - 12\u00ba andar',
      districtLine: 'Vila Ol\u00edmpia, S\u00e3o Paulo - SP',
      zipCode: '04551-000',
      icon: Icons.work_rounded,
    ),
  ];

  List<DeliveryAddress> get addresses =>
      List<DeliveryAddress>.unmodifiable(_addresses);

  String get registeredAddressesLabel {
    final count = _addresses.length;
    return '$count REGISTRADO${count == 1 ? '' : 'S'}';
  }

  String get addAddressMessage =>
      'Fluxo para adicionar endere\u00e7o em constru\u00e7\u00e3o.';

  String get editAddressMessage =>
      'Fluxo para editar endere\u00e7o em constru\u00e7\u00e3o.';

  String get deleteAddressMessage =>
      'Remo\u00e7\u00e3o de endere\u00e7o em constru\u00e7\u00e3o.';

  String get unavailableScreenMessage => 'Tela em constru\u00e7\u00e3o.';
}

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
}
