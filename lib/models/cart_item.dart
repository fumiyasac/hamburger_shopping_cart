// Burger モデルクラスをインポート
import 'burger.dart';

// カート内のアイテム（商品と数量のペア）を表すモデルクラス
class CartItem {
  final Burger burger;   // カートに入れたバーガーの情報
  final int quantity;    // カートに入れた数量

  // コンストラクタ
  CartItem({
    required this.burger,
    required this.quantity,
  });

  // copyWith メソッド: 既存のオブジェクトの一部を変更した新しいオブジェクトを作成
  // 主に数量を変更する際に使用される
  CartItem copyWith({
    Burger? burger,
    int? quantity,
  }) {
    return CartItem(
      burger: burger ?? this.burger,
      quantity: quantity ?? this.quantity,
    );
  }

  // ゲッター: プロパティのように使える計算結果
  // このアイテムの合計金額を計算して返す（単価 × 数量）
  // get を付けることで、totalPrice() ではなく totalPrice としてアクセスできる
  double get totalPrice => burger.price * quantity;
}
