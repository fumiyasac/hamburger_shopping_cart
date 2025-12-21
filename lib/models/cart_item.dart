import 'burger.dart';

class CartItem {
  final Burger burger;
  final int quantity;

  CartItem({
    required this.burger,
    required this.quantity,
  });

  CartItem copyWith({
    Burger? burger,
    int? quantity,
  }) {
    return CartItem(
      burger: burger ?? this.burger,
      quantity: quantity ?? this.quantity,
    );
  }

  double get totalPrice => burger.price * quantity;
}
