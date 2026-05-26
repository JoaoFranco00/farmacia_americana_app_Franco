import 'package:flutter/material.dart';
import 'package:farmacia_app/features/client/orders/data/models/order_model.dart';

class OrderDetailViewModel extends ChangeNotifier {
  final Order order;

  OrderDetailViewModel({required this.order});

  String get formattedTotal =>
      'R\$ ${order.totalAmount.toStringAsFixed(2).replaceAll('.', ',')}';

  String get formattedDate {
    final d = order.createdAt;
    return '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}  ${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
  }

  String? get formattedEstimatedDelivery {
    if (order.estimatedDelivery == null) return null;
    final d = order.estimatedDelivery!;
    return '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year} às ${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
  }

  bool get canTrack =>
      order.status == OrderStatus.transit &&
      order.trackingCode != null &&
      !order.isPickup;

  bool get isActive => order.status.isActive;
}
