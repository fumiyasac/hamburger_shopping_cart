import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../repositories/burger_repository.dart';
import '../repositories/cart_repository.dart';
import '../models/burger.dart';
import '../models/cart_item.dart';

part 'providers.g.dart';

// Repository Providers
@riverpod
BurgerRepository burgerRepository(Ref ref) {
  return BurgerRepository();
}

@riverpod
CartRepository cartRepository(Ref ref) {
  return CartRepository();
}

// Burger List Provider
@riverpod
class BurgerList extends _$BurgerList {
  @override
  Future<List<Burger>> build() async {
    final repository = ref.watch(burgerRepositoryProvider);
    return repository.getAllBurgers();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(burgerRepositoryProvider);
      return repository.getAllBurgers();
    });
  }
}

// All Ingredients Provider
@riverpod
Future<List<String>> allIngredients(Ref ref) async {
  final repository = ref.watch(burgerRepositoryProvider);
  return repository.getAllIngredients();
}

// Search Provider (単一パラメータ版)
@riverpod
class BurgerSearch extends _$BurgerSearch {
  @override
  Future<List<Burger>> build(String query) async {
    final repository = ref.watch(burgerRepositoryProvider);
    return repository.searchBurgers(query);
  }
}

// Cart Provider
@riverpod
class Cart extends _$Cart {
  @override
  Future<List<CartItem>> build() async {
    final repository = ref.watch(cartRepositoryProvider);
    return repository.getCartItems();
  }

  Future<void> addToCart(Burger burger) async {
    final repository = ref.read(cartRepositoryProvider);
    await repository.addToCart(burger);
    ref.invalidateSelf();
  }

  Future<void> removeFromCart(String burgerId) async {
    final repository = ref.read(cartRepositoryProvider);
    await repository.removeFromCart(burgerId);
    ref.invalidateSelf();
  }

  Future<void> updateQuantity(String burgerId, int quantity) async {
    final repository = ref.read(cartRepositoryProvider);
    await repository.updateQuantity(burgerId, quantity);
    ref.invalidateSelf();
  }

  Future<void> clearCart() async {
    final repository = ref.read(cartRepositoryProvider);
    await repository.clearCart();
    ref.invalidateSelf();
  }
}

// Cart Total Provider
@riverpod
Future<double> cartTotal(Ref ref) async {
  final cartItems = await ref.watch(cartProvider.future);
  return cartItems.fold<double>(0.0, (sum, item) => sum + item.totalPrice);
}

// Cart Item Count Provider
@riverpod
Future<int> cartItemCount(Ref ref) async {
  final cartItems = await ref.watch(cartProvider.future);
  return cartItems.fold<int>(0, (sum, item) => sum + item.quantity);
}