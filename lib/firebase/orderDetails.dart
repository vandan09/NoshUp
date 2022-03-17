class OrderDetail {
  String? item_name;
  String? price;
  String? total_qty;
  //String? catValue;

  OrderDetail({this.item_name, this.price, this.total_qty});

  //recieve data from server
  factory OrderDetail.fromMap(map) {
    return OrderDetail(
      item_name: map["item_name"],
      price: map["price"],
      total_qty: map["total_qty"],
      //catValue: map["qauntity"],
    );
  }

  //send data to server
  Map<String, dynamic> toMap() {
    return {
      "item_name": item_name,
      "price": int.parse(price!),
      "total_qty": int.parse(total_qty!),
      //"catValue": qauntity,
    };
  }
}
