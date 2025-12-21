import '../models/cart_item.dart';
import '../models/burger.dart';

class CartRepository {
  final List<CartItem> _cartItems = [];

  Future<List<CartItem>> getCartItems() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return List.from(_cartItems);
  }

  Future<void> addToCart(Burger burger) async {
    await Future.delayed(const Duration(milliseconds: 100));
    
    final existingIndex = _cartItems.indexWhere(
      (item) => item.burger.id == burger.id,
    );

    if (existingIndex != -1) {
      _cartItems[existingIndex] = _cartItems[existingIndex].copyWith(
        quantity: _cartItems[existingIndex].quantity + 1,
      );
    } else {
      _cartItems.add(CartItem(burger: burger, quantity: 1));
    }
  }

  Future<void> removeFromCart(String burgerId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _cartItems.removeWhere((item) => item.burger.id == burgerId);
  }

  Future<void> updateQuantity(String burgerId, int quantity) async {
    await Future.delayed(const Duration(milliseconds: 100));
    
    if (quantity <= 0) {
      await removeFromCart(burgerId);
      return;
    }

    final index = _cartItems.indexWhere(
      (item) => item.burger.id == burgerId,
    );

    if (index != -1) {
      _cartItems[index] = _cartItems[index].copyWith(quantity: quantity);
    }
  }

  Future<void> clearCart() async {
    await Future.delayed(const Duration(milliseconds: 100));
    _cartItems.clear();
  }

  Future<double> getTotalPrice() async {
    await Future.delayed(const Duration(milliseconds: 50));
    return _cartItems.fold<double>(
      0,
      (sum, item) => sum + item.totalPrice.toDouble(),
    );
  }
}
