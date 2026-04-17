import 'package:flutter/material.dart';

class PaymentMethodsViewModel extends ChangeNotifier {
  final List<PaymentMethodCard> _methods = const [
    PaymentMethodCard(
      id: 'visa-gold-4242',
      title: 'Visa Gold',
      subtitle: 'Final •••• 4242',
      icon: Icons.credit_card_rounded,
      maskedNumber: '• • • •   • • • •   • • • •   4242',
      holderName: 'MARCOS A. SILVA',
      expiryDate: '09/28',
      isDefault: true,
    ),
    PaymentMethodCard(
      id: 'mastercard-black-8812',
      title: 'Mastercard Black',
      subtitle: 'Final •••• 8812',
      icon: Icons.credit_card_rounded,
      maskedNumber: '• • • •   • • • •   • • • •   8812',
      holderName: 'MARCOS A. SILVA',
      expiryDate: '01/29',
    ),
  ];

  List<PaymentMethodCard> get methods => List<PaymentMethodCard>.unmodifiable(_methods);

  PaymentMethodCard get primaryMethod => _methods.firstWhere(
        (method) => method.isDefault,
        orElse: () => _methods.first,
      );

  List<PaymentMethodCard> get savedMethods => methods
      .where((method) => !method.isDefault)
      .toList(growable: false);

  String get savedMethodsLabel {
    final count = savedMethods.length;
    return '$count SALVO${count == 1 ? '' : 'S'}';
  }

  String get addCardMessage => 'Fluxo para adicionar cartão em construção.';

  String get cardActionsMessage => 'Ações do cartão em construção.';

  String get unavailableScreenMessage => 'Tela em construção.';
}

class PaymentMethodCard {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final String maskedNumber;
  final String holderName;
  final String expiryDate;
  final bool isDefault;

  const PaymentMethodCard({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.maskedNumber,
    required this.holderName,
    required this.expiryDate,
    this.isDefault = false,
  });
}
