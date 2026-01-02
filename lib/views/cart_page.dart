// Flutterのコアパッケージ
import 'package:flutter/material.dart';
// Riverpod（状態管理ライブラリ）
import 'package:flutter_riverpod/flutter_riverpod.dart';
// プロバイダー（状態管理）
import '../viewmodels/providers.dart';
// カートアイテムカードウィジェット
import '../widgets/cart_item_card.dart';
// 注文完了ページ
import 'order_complete_page.dart';

// カートページ: カート内のアイテムを表示し、数量調整や購入処理を行う画面
// ConsumerWidget を使用することで、Riverpod のプロバイダーから状態を取得・監視できる
class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // カートの状態を監視（AsyncValue で非同期の状態を扱う）
    // カートの内容が変更されると、自動的に UI が再描画される
    final cartAsync = ref.watch(cartProvider);
    // カートの操作を行うための notifier を取得（追加、削除、更新など）
    // ref.read: 値を一度だけ読み取る（変更を監視しない）
    final cartNotifier = ref.read(cartProvider.notifier);

    // Scaffold: Material Design の基本的なレイアウト構造を提供
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      // AppBar: 画面上部のバー
      appBar: AppBar(
        title: Text(
          'CART',
          style: TextStyle(
            fontWeight: FontWeight.w900,   // フォントの太さ（最も太い）
            letterSpacing: 1.5,            // 文字間隔
            fontSize: 18,                  // フォントサイズ
            color: Colors.grey.shade900,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,                      // 影の高さ（0で影なし）
        centerTitle: false,                // タイトルを左寄せ
        // bottom: AppBar の下部に表示するウィジェット
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            color: Colors.grey.shade200,   // 薄い灰色の線（区切り線）
          ),
        ),
      ),
      // when メソッド: AsyncValue の状態（data, loading, error）に応じて異なる UI を表示
      // 非同期処理の状態管理を簡潔に実装できる
      body: cartAsync.when(
        // data: データの取得が成功した場合
        // cartItems: カート内のアイテムのリスト
        data: (cartItems) {
          // カートが空の場合は、空の状態を示す UI を表示
          if (cartItems.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 大きなショッピングカートアイコン
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 100,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 20),
                  // メインメッセージ
                  Text(
                    'カートは空です',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // サブメッセージ
                  Text(
                    'お気に入りのバーガーを追加しましょう',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            );
          }

          // カートに商品がある場合は、合計金額を取得
          final totalAsync = ref.watch(cartTotalProvider);

          return Column(
            children: [
              // カートアイテムリスト
              // Expanded: 親ウィジェットの利用可能なスペースを埋める
              Expanded(
                // ListView.builder: スクロール可能なリストを効率的に構築
                // 必要な分だけアイテムを生成するため、パフォーマンスが良い
                child: ListView.builder(
                  // padding: リストの内側の余白（上16、下100で購入ボタンの領域を確保）
                  padding: const EdgeInsets.only(top: 16, bottom: 100),
                  itemCount: cartItems.length,              // リストのアイテム数
                  // itemBuilder: 各アイテムの UI を構築する関数
                  // index: リスト内のアイテムの位置（0から始まる）
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    // カートアイテムカードを表示
                    return CartItemCard(
                      item: item,
                      // 数量を増やすボタンのコールバック
                      onIncrease: () {
                        cartNotifier.updateQuantity(
                          item.burger.id,
                          item.quantity + 1,
                        );
                      },
                      // 数量を減らすボタンのコールバック
                      onDecrease: () {
                        cartNotifier.updateQuantity(
                          item.burger.id,
                          item.quantity - 1,
                        );
                      },
                      // 削除ボタンのコールバック
                      onRemove: () {
                        cartNotifier.removeFromCart(item.burger.id);
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
        // loading: データの取得中（ローディング状態）
        loading: () => Center(
          child: CircularProgressIndicator(
            color: Colors.grey.shade400,
            strokeWidth: 2,
          ),
        ),
        // error: データの取得に失敗した場合
        error: (error, stack) => Center(
          child: Icon(
            Icons.error_outline_rounded,
            size: 60,
            color: Colors.grey.shade400,
          ),
        ),
      ),
      // bottomSheet: 画面下部に固定表示されるウィジェット（購入ボタンと合計金額）
      // maybeWhen: when と似ているが、orElse で他のケースをまとめて処理できる
      bottomSheet: cartAsync.maybeWhen(
        data: (cartItems) {
          // カートが空の場合は何も表示しない
          if (cartItems.isEmpty) return null;
          final totalAsync = ref.watch(cartTotalProvider);

          return Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              // 上部に影を付けて、リストと分離されているように見せる
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),  // 上方向に影を表示
                ),
              ],
            ),
            // SafeArea: ノッチやステータスバーなどの安全領域を考慮してレイアウト
            child: SafeArea(
              child: Row(
                children: [
                  // 左側: 合計金額の表示エリア
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,  // 必要最小限の高さにする
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ラベル
                        Text(
                          '合計',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 2),
                        // 合計金額（AsyncValue の状態に応じて表示を変える）
                        totalAsync.when(
                          data: (total) => Text(
                            '¥${total.toStringAsFixed(0)}',  // 小数点以下を表示しない
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: Colors.grey.shade900,
                              letterSpacing: -0.5,
                            ),
                          ),
                          loading: () => const SizedBox(
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                          error: (_, __) => const Text('--'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  // 右側: 購入ボタン
                  Expanded(
                    child: SizedBox(
                      height: 54,
                      // ElevatedButton: Material Design の立体的なボタン
                      child: ElevatedButton(
                        // onPressed: ボタンがタップされた時の処理
                        onPressed: () async {
                          // カートをクリアして注文を完了
                          await cartNotifier.clearCart();
                          // context.mounted: ウィジェットがまだツリーに存在するか確認
                          // 非同期処理後にウィジェットが破棄されている可能性があるためチェック
                          if (context.mounted) {
                            // 注文完了ページに遷移
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const OrderCompletePage(),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF6B9D),  // ボタンの背景色
                          foregroundColor: Colors.white,              // テキストの色
                          elevation: 0,                               // ボタンの影の高さ
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),  // 角丸
                          ),
                        ),
                        child: const Text(
                          '購入する',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        // それ以外の状態（loading や error）では何も表示しない
        orElse: () => null,
      ),
    );
  }
}
