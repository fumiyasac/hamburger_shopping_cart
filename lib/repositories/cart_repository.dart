// CartItem と Burger モデルクラスをインポート
import '../models/cart_item.dart';
import '../models/burger.dart';

// カートのデータを管理するリポジトリクラス
// ショッピングカート機能（追加、削除、数量変更など）を提供
class CartRepository {
  // カート内のアイテムを保持するリスト（プライベート）
  final List<CartItem> _cartItems = [];

  // カート内のすべてのアイテムを取得
  Future<List<CartItem>> getCartItems() async {
    await Future.delayed(const Duration(milliseconds: 100));
    // List.from: リストのコピーを作成（元のリストを直接返さない）
    // これにより、外部から _cartItems を直接変更されることを防ぐ
    return List.from(_cartItems);
  }

  // カートにバーガーを追加
  Future<void> addToCart(Burger burger) async {
    await Future.delayed(const Duration(milliseconds: 100));

    // indexWhere: 条件に一致する要素のインデックスを取得（見つからない場合は -1）
    final existingIndex = _cartItems.indexWhere(
      (item) => item.burger.id == burger.id,
    );

    // 既にカートに同じバーガーがある場合
    if (existingIndex != -1) {
      // 数量を +1 した新しい CartItem で置き換える
      // イミュータブルなので、既存のアイテムを変更するのではなく、新しいアイテムを作成
      _cartItems[existingIndex] = _cartItems[existingIndex].copyWith(
        quantity: _cartItems[existingIndex].quantity + 1,
      );
    } else {
      // まだカートにない場合は、数量 1 で新規追加
      _cartItems.add(CartItem(burger: burger, quantity: 1));
    }
  }

  // カートから指定したバーガーを削除
  Future<void> removeFromCart(String burgerId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    // removeWhere: 条件に一致する要素をすべて削除
    _cartItems.removeWhere((item) => item.burger.id == burgerId);
  }

  // カート内のバーガーの数量を変更
  Future<void> updateQuantity(String burgerId, int quantity) async {
    await Future.delayed(const Duration(milliseconds: 100));

    // 数量が 0 以下の場合はカートから削除
    if (quantity <= 0) {
      await removeFromCart(burgerId);
      return; // 処理を終了
    }

    // 指定した ID のアイテムのインデックスを取得
    final index = _cartItems.indexWhere(
      (item) => item.burger.id == burgerId,
    );

    // アイテムが見つかった場合、新しい数量で置き換え
    if (index != -1) {
      _cartItems[index] = _cartItems[index].copyWith(quantity: quantity);
    }
  }

  // カートを空にする（注文完了時などに使用）
  Future<void> clearCart() async {
    await Future.delayed(const Duration(milliseconds: 100));
    // clear: リストのすべての要素を削除
    _cartItems.clear();
  }

  // カート内の商品の合計金額を計算
  Future<double> getTotalPrice() async {
    await Future.delayed(const Duration(milliseconds: 50));
    // fold: リストの要素を集約して1つの値にする（reduce の一種）
    // 初期値 0 から開始し、各アイテムの totalPrice を加算していく
    // sum は累積値、item は現在処理中のアイテム
    return _cartItems.fold<double>(
      0,                                    // 初期値
      (sum, item) => sum + item.totalPrice.toDouble(),  // 累積関数
    );
  }
}
