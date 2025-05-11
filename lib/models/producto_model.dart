import 'dart:convert';

class ProductItem {
  final int productId;
  final String productName;
  final int productPrice;
  final String productImage;
  final String productState;

  ProductItem({
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.productImage,
    required this.productState,
  });

  factory ProductItem.fromJson(String str) =>
      ProductItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductItem.fromMap(Map<String, dynamic> json) => ProductItem(
    productId: json["product_id"],
    productName: json["product_name"],
    productPrice: json["product_price"],
    productImage: json["product_image"],
    productState: json["product_state"],
  );

  Map<String, dynamic> toMap() => {
    "product_id": productId,
    "product_name": productName,
    "product_price": productPrice,
    "product_image": productImage,
    "product_state": productState,
  };
}
