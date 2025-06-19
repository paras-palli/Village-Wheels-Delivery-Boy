class OrderModel {
  final String imageUrl;
  final String name;
  final String unit;
  final double price;
  final int quantity;

  OrderModel({
    required this.imageUrl,
    required this.name,
    required this.unit,
    required this.price,
    required this.quantity,
  });
}
