import 'package:farmacia_app/features/client/orders/data/mocks/mock_orders.dart';
import 'package:farmacia_app/features/client/orders/data/models/order_model.dart';
import 'package:flutter/foundation.dart';

class OrdersStore extends ChangeNotifier {
  OrdersStore._() {
    _orders = MockOrders.getOrders()..sort(_sortByNewest);
  }

  static final OrdersStore instance = OrdersStore._();

  late List<Order> _orders;

  List<Order> get orders => List<Order>.unmodifiable(_orders);

  void addOrder(Order order) {
    _orders = [order, ..._orders]..sort(_sortByNewest);
    notifyListeners();
  }

  int _sortByNewest(Order a, Order b) => b.createdAt.compareTo(a.createdAt);
}
