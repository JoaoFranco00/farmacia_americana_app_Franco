enum OrderStatus {
  pending,
  confirmed,
  preparing,
  transit,
  delivered,
  cancelled,
}

extension OrderStatusExtension on OrderStatus {
  String get label {
    switch (this) {
      case OrderStatus.pending:
        return 'Aguardando confirmação';
      case OrderStatus.confirmed:
        return 'Confirmado';
      case OrderStatus.preparing:
        return 'Em preparo';
      case OrderStatus.transit:
        return 'Em trânsito';
      case OrderStatus.delivered:
        return 'Entregue';
      case OrderStatus.cancelled:
        return 'Cancelado';
    }
  }

  bool get isActive =>
      this != OrderStatus.delivered && this != OrderStatus.cancelled;
}

enum PaymentMethod { pix, cashOnDelivery, cardOnDelivery }

extension PaymentMethodExtension on PaymentMethod {
  String get label {
    switch (this) {
      case PaymentMethod.pix:
        return 'Pix';
      case PaymentMethod.cashOnDelivery:
        return 'Dinheiro';
      case PaymentMethod.cardOnDelivery:
        return 'Cartão de Crédito';
    }
  }
}

class OrderItem {
  final String productId;
  final String productName;
  final String productImageUrl;
  final int quantity;
  final double unitPrice;

  const OrderItem({
    required this.productId,
    required this.productName,
    required this.productImageUrl,
    required this.quantity,
    required this.unitPrice,
  });

  double get subtotal => unitPrice * quantity;
}

class Order {
  final String id;
  final String userId;
  final List<OrderItem> items;
  final OrderStatus status;
  final PaymentMethod paymentMethod;
  final double totalAmount;
  final String deliveryAddress;
  final DateTime createdAt;
  final DateTime? estimatedDelivery;
  final String? trackingCode;

  const Order({
    required this.id,
    required this.userId,
    required this.items,
    required this.status,
    required this.paymentMethod,
    required this.totalAmount,
    required this.deliveryAddress,
    required this.createdAt,
    this.estimatedDelivery,
    this.trackingCode,
  });

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);
}
