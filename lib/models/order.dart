class OrderItem {
  String id;

  OrderItem(this.id);
  Map<String, dynamic> toMapForOrder() {
    Map<String, dynamic> map = {};
    map['order_id'] = id;

    return map;
  }
}

class Order {
  String orderId;
  String orderDate;
  double totalAmount;
  bool status;
  List<OrderItem> items;

  Order(
      this.items, this.orderDate, this.orderId, this.status, this.totalAmount);
}
