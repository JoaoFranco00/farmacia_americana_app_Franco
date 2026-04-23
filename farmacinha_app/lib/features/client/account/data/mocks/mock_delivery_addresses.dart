import 'package:farmacia_app/features/client/account/data/models/delivery_address_model.dart';
import 'package:flutter/material.dart';

class MockDeliveryAddresses {
  static List<DeliveryAddress> getAddresses() {
    return const [
      DeliveryAddress(
        id: 'home-main',
        title: 'Minha Casa',
        recipient: 'Ricardo Oliveira',
        streetLine: 'Avenida Paulista, 1578 - Apto 42',
        districtLine: 'Bela Vista, São Paulo - SP',
        zipCode: '01310-200',
        icon: Icons.home_rounded,
        isDefault: true,
      ),
      DeliveryAddress(
        id: 'work',
        title: 'Trabalho',
        recipient: 'Ricardo Oliveira',
        streetLine: 'Rua das Olimpíadas, 205 - 12º andar',
        districtLine: 'Vila Olímpia, São Paulo - SP',
        zipCode: '04551-000',
        icon: Icons.work_rounded,
      ),
    ];
  }
}
