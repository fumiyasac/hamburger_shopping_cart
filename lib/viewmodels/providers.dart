// Riverpod のコード生成用アノテーションをインポート
import 'package:riverpod_annotation/riverpod_annotation.dart';
// リポジトリクラスをインポート
import '../repositories/burger_repository.dart';
import '../repositories/cart_repository.dart';
// モデルクラスをインポート
import '../models/burger.dart';
import '../models/cart_item.dart';

// 自動生成されたコードをインポート
// build_runner により providers.g.dart が生成される
// コマンド: dart run build_runner build
part 'providers.g.dart';

// ========== Repository Providers ==========
// リポジトリのインスタンスを提供するプロバイダー

// @riverpod アノテーション: Riverpod のコード生成を有効にする
// BurgerRepository のインスタンスを作成して提供
// Ref: プロバイダー間の依存関係を管理するオブジェクト
@riverpod
BurgerRepository burgerRepository(Ref ref) {
  return BurgerRepository();
}

// CartRepository のインスタンスを作成して提供
@riverpod
CartRepository cartRepository(Ref ref) {
  return CartRepository();
}

// ========== Burger List Provider ==========
// バーガーのリスト全体を管理するプロバイダー

// @riverpod クラス: 状態を持つプロバイダーを定義
// 自動的に BurgerListProvider という名前のプロバイダーが生成される
@riverpod
class BurgerList extends _$BurgerList {
  // build メソッド: プロバイダーの初期状態を定義
  // この場合、リポジトリから全バーガーを取得して返す
  @override
  Future<List<Burger>> build() async {
    // ref.watch: 他のプロバイダーを監視し、その値を取得
    // burgerRepositoryProvider が変更されると、このプロバイダーも再構築される
    final repository = ref.watch(burgerRepositoryProvider);
    return repository.getAllBurgers();
  }

  // リストを再取得するメソッド（リフレッシュ機能などで使用）
  Future<void> refresh() async {
    // state に AsyncValue.loading() を設定して、ローディング状態にする
    state = const AsyncValue.loading();
    // AsyncValue.guard: 非同期処理を実行し、成功/失敗を AsyncValue で返す
    state = await AsyncValue.guard(() async {
      final repository = ref.read(burgerRepositoryProvider);
      return repository.getAllBurgers();
    });
  }
}

// ========== All Ingredients Provider ==========
// すべての食材のリストを提供するプロバイダー
// 食材フィルター機能で使用

@riverpod
Future<List<String>> allIngredients(Ref ref) async {
  final repository = ref.watch(burgerRepositoryProvider);
  return repository.getAllIngredients();
}

// ========== Search Provider ==========
// バーガー検索機能を提供するプロバイダー
// query パラメータに応じて異なる検索結果を返す

@riverpod
class BurgerSearch extends _$BurgerSearch {
  // build メソッド: パラメータ（query）を受け取り、検索結果を返す
  // query が変わるたびに新しいプロバイダーインスタンスが作られる
  @override
  Future<List<Burger>> build(String query) async {
    final repository = ref.watch(burgerRepositoryProvider);
    return repository.searchBurgers(query);
  }
}

// ========== Cart Provider ==========
// カートの状態を管理するプロバイダー
// カート内のアイテムの追加・削除・更新を行う

@riverpod
class Cart extends _$Cart {
  // build メソッド: カートの初期状態（カート内のアイテムリスト）を返す
  @override
  Future<List<CartItem>> build() async {
    final repository = ref.watch(cartRepositoryProvider);
    return repository.getCartItems();
  }

  // カートにバーガーを追加
  Future<void> addToCart(Burger burger) async {
    final repository = ref.read(cartRepositoryProvider);
    await repository.addToCart(burger);
    // ref.invalidateSelf: このプロバイダー自身を無効化して再構築
    // これにより、最新のカート内容が UI に反映される
    ref.invalidateSelf();
  }

  // カートからアイテムを削除
  Future<void> removeFromCart(String burgerId) async {
    final repository = ref.read(cartRepositoryProvider);
    await repository.removeFromCart(burgerId);
    ref.invalidateSelf();
  }

  // カート内のアイテムの数量を更新
  Future<void> updateQuantity(String burgerId, int quantity) async {
    final repository = ref.read(cartRepositoryProvider);
    await repository.updateQuantity(burgerId, quantity);
    ref.invalidateSelf();
  }

  // カートを空にする
  Future<void> clearCart() async {
    final repository = ref.read(cartRepositoryProvider);
    await repository.clearCart();
    ref.invalidateSelf();
  }
}

// ========== Cart Total Provider ==========
// カート内の商品の合計金額を計算するプロバイダー

@riverpod
Future<double> cartTotal(Ref ref) async {
  // ref.watch(cartProvider.future): Cart プロバイダーの Future を監視
  // cartProvider が変更されると、自動的に再計算される
  final cartItems = await ref.watch(cartProvider.future);
  // fold を使って全アイテムの合計金額を計算
  return cartItems.fold<double>(0.0, (sum, item) => sum + item.totalPrice);
}

// ========== Cart Item Count Provider ==========
// カート内のアイテムの総数を計算するプロバイダー
// BottomNavigationBar のバッジ表示などで使用

@riverpod
Future<int> cartItemCount(Ref ref) async {
  final cartItems = await ref.watch(cartProvider.future);
  // 各アイテムの quantity を合計して、カート内の総アイテム数を計算
  return cartItems.fold<int>(0, (sum, item) => sum + item.quantity);
}
