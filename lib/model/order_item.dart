class OrderItem {
     final int productId;
     final int quantity;
     OrderItem({required this.productId, required this.quantity});
     Map<String, dynamic> toJson() => {
       "product_id" : productId,
       "quantity" : quantity,
     };
}