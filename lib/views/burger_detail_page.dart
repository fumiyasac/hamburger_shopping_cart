// Flutter のコアパッケージ
import 'package:flutter/material.dart';
// Riverpod（状態管理ライブラリ）
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ネットワーク画像キャッシュパッケージ
import 'package:cached_network_image/cached_network_image.dart';
// バーガーモデル
import '../models/burger.dart';
// プロバイダー（状態管理）
import '../viewmodels/providers.dart';

// バーガー詳細ページ: 選択したバーガーの詳細情報を表示する画面
// 画像、価格、カロリー、説明、材料、アレルギー情報、お客様の声などを表示
class BurgerDetailPage extends ConsumerWidget {
  // 表示するバーガーの情報
  final Burger burger;

  const BurgerDetailPage({super.key, required this.burger});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // カートの操作を行うための notifier を取得
    final cartNotifier = ref.read(cartProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      // CustomScrollView: 複雑なスクロール動作を実装するためのウィジェット
      // Sliver ウィジェットを組み合わせて柔軟なスクロールレイアウトを作成できる
      body: CustomScrollView(
        // slivers: スクロール可能な要素のリスト
        slivers: [
          // SliverAppBar: スクロールに応じて拡大縮小する AppBar
          // 画像を含む AppBar を作成するのに適している
          SliverAppBar(
            expandedHeight: 350,           // 拡張時の高さ
            pinned: true,                  // スクロール時に AppBar を画面上部に固定
            backgroundColor: Colors.white,
            // 戻るボタンのカスタマイズ
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,    // 円形
                  // ボタンに影を付けて目立たせる
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.grey.shade900,
                    size: 22,
                  ),
                  // 前の画面に戻る
                  onPressed: () => Navigator.of(context).pop(),
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
            // FlexibleSpaceBar: SliverAppBar 内で拡張可能なスペースを作成
            flexibleSpace: FlexibleSpaceBar(
              // background: 拡張時に表示される背景（画像を表示）
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // バーガーの画像
                  CachedNetworkImage(
                    imageUrl: burger.imageUrl,
                    fit: BoxFit.cover,  // 画像を領域全体に広げる
                    // ローディング中の表示
                    placeholder: (context, url) => Container(
                      color: Colors.grey.shade100,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                    // エラー時の表示
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey.shade200,
                      child: const Icon(
                        Icons.fastfood,
                        size: 80,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  // 画像の下部にグラデーションを追加（テキストを読みやすくする）
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    height: 100,
                    child: Container(
                      decoration: BoxDecoration(
                        // LinearGradient: 線形グラデーション
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,            // 上部: 透明
                            Colors.white.withOpacity(0.9), // 下部: 半透明の白
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // SliverToBoxAdapter: Sliver ではない通常のウィジェットを CustomScrollView 内で使用
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // バーガー名
                  Text(
                    burger.name,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: Colors.grey.shade900,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // 価格とカロリーの行
                  Row(
                    children: [
                      // 価格
                      Text(
                        '¥${burger.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFFFF6B9D),
                          letterSpacing: -1,
                        ),
                      ),
                      // Spacer: 利用可能なスペースを埋める（価格とカロリーを両端に配置）
                      const Spacer(),
                      // カロリーバッジ
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.local_fire_department,
                              color: Colors.orange.shade600,
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${burger.calories} kcal',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey.shade800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // 区切り線
                  Container(
                    height: 1,
                    color: Colors.grey.shade200,
                  ),
                  const SizedBox(height: 24),

                  // 商品説明
                  Text(
                    burger.description,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade700,
                      height: 1.7,       // 行間の高さ
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // お店からのおすすめコメント
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      // withOpacity: 色の透明度を設定（0.0=透明、1.0=不透明）
                      color: const Color(0xFFFF6B9D).withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFFF6B9D).withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ヘッダー（店舗アイコン + テキスト）
                        Row(
                          children: [
                            // アイコンを囲むピンクの背景
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFF6B9D),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Icon(
                                Icons.store_rounded,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'お店からのおすすめ',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey.shade900,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // おすすめコメント本文
                        Text(
                          burger.recommendComment,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // 材料セクション
                  Text(
                    '材料',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Colors.grey.shade900,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 材料のタグを横に並べる（Wrap を使用）
                  // Wrap: 子ウィジェットを横に並べ、スペースが足りなくなったら次の行に折り返す
                  Wrap(
                    spacing: 8,       // 横方向の間隔
                    runSpacing: 8,    // 縦方向の間隔（折り返し時）
                    // map: リストの各要素を別の形に変換
                    // toList: 変換結果をリストに戻す
                    children: burger.ingredients.map((ingredient) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          ingredient,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 32),

                  // アレルギー情報セクション
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,   // オレンジ色の背景で注意を引く
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.orange.shade200,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ヘッダー（警告アイコン + テキスト）
                        Row(
                          children: [
                            Icon(
                              Icons.warning_amber_rounded,
                              color: Colors.orange.shade700,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'アレルギー情報',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey.shade900,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // アレルゲンのタグを横に並べる
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: burger.allergens.map((allergen) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: Colors.orange.shade300,
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                allergen,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.orange.shade900,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // お客様の声セクション
                  Text(
                    'お客様の声',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Colors.grey.shade900,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // レビューのリスト
                  // ...演算子（スプレッド演算子）: リストを展開して個別の要素として挿入
                  ...burger.customerReviews.map((review) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey.shade200,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // レビューのヘッダー（アバター、ユーザー名、評価、日付）
                          Row(
                            children: [
                              // CircleAvatar: 円形のアバター
                              CircleAvatar(
                                radius: 16,
                                backgroundColor: const Color(0xFFFF6B9D)
                                    .withOpacity(0.1),
                                // ユーザー名の最初の1文字を表示
                                child: Text(
                                  review.userName[0],
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFFFF6B9D),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              // ユーザー名と評価の星
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // ユーザー名
                                    Text(
                                      review.userName,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.grey.shade900,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    // 評価の星（5段階評価）
                                    Row(
                                      children: [
                                        // List.generate: 指定した数だけウィジェットを生成
                                        ...List.generate(5, (index) {
                                          // 評価に応じて星のアイコンを変える
                                          // 例: 評価 4.5 の場合、星4つと半分の星1つを表示
                                          return Icon(
                                            index < review.rating.floor()  // floor: 小数点以下切り捨て
                                                ? Icons.star_rounded        // 塗りつぶしの星
                                                : (index < review.rating
                                                ? Icons.star_half_rounded   // 半分の星
                                                : Icons.star_outline_rounded), // 空の星
                                            size: 14,
                                            color: Colors.amber.shade600,
                                          );
                                        }),
                                        const SizedBox(width: 6),
                                        // 数値での評価表示
                                        Text(
                                          review.rating.toStringAsFixed(1),  // 小数点第1位まで表示
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // レビューの投稿日
                              Text(
                                review.date,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          // レビューコメント
                          Text(
                            review.comment,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade700,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 40),

                  // カートに追加ボタン
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      // async: 非同期処理を含む関数
                      onPressed: () async {
                        // カートにバーガーを追加
                        await cartNotifier.addToCart(burger);
                        // context.mounted: ウィジェットがまだツリーに存在するか確認
                        if (context.mounted) {
                          // SnackBar: 画面下部に一時的に表示される通知バー
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                children: [
                                  const Icon(
                                    Icons.check_circle_rounded,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 12),
                                  const Expanded(
                                    child: Text(
                                      'カートに追加しました',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              backgroundColor: Colors.grey.shade900,
                              behavior: SnackBarBehavior.floating,  // 浮いたスタイル
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              duration: const Duration(seconds: 2),  // 2秒間表示
                              margin: const EdgeInsets.all(16),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF6B9D),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_shopping_cart_rounded, size: 22),
                          SizedBox(width: 10),
                          Text(
                            'カートに追加',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
