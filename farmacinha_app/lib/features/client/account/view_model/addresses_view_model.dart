import 'package:farmacia_app/features/client/account/data/mocks/mock_delivery_addresses.dart';
import 'package:farmacia_app/features/client/account/data/models/delivery_address_model.dart';
import 'package:flutter/foundation.dart';

class AddressesViewModel extends ChangeNotifier {
  final List<DeliveryAddress> _addresses = MockDeliveryAddresses.getAddresses();

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
