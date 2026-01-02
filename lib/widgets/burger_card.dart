import 'package:flutter/material.dart';
// cached_network_image: ネットワーク画像をキャッシュして表示するパッケージ
import 'package:cached_network_image/cached_network_image.dart';
import '../models/burger.dart';

// バーガーカード: バーガーの情報を表示する再利用可能なウィジェット
// グリッド表示やリスト表示で使用される
class BurgerCard extends StatelessWidget {
  final Burger burger;              // 表示するバーガーの情報
  final VoidCallback? onTap;        // カードがタップされた時のコールバック
  final VoidCallback? onAddToCart;  // カートボタンがタップされた時のコールバック

  // コンストラクタ
  const BurgerCard({
    super.key,
    required this.burger,
    this.onTap,         // オプション（null 許容）
    this.onAddToCart,   // オプション（null 許容）
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 画像セクション
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    // CachedNetworkImage: ネットワーク画像を効率的に表示
                    // 一度読み込んだ画像をキャッシュし、次回は高速に表示できる
                    child: CachedNetworkImage(
                      imageUrl: burger.imageUrl,      // 画像の URL
                      height: 110,                    // 高さ
                      width: double.infinity,         // 幅（親の幅いっぱい）
                      fit: BoxFit.cover,              // 画像のフィット方法（領域を埋める）
                      // placeholder: 画像読み込み中に表示するウィジェット
                      placeholder: (context, url) => Container(
                        height: 110,
                        color: Colors.grey.shade100,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.grey.shade400,
                            strokeWidth: 2,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        height: 110,
                        color: Colors.grey.shade100,
                        child: Icon(
                          Icons.fastfood_rounded,
                          size: 40,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                  ),
                  // カロリーバッジ
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.local_fire_department,
                            size: 12,
                            color: Colors.orange.shade600,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '${burger.calories}',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // コンテンツセクション
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 名前
                      Text(
                        burger.name,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey.shade900,
                          letterSpacing: -0.3,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      // 説明
                      Expanded(
                        child: Text(
                          burger.description,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                            height: 1.4,
                            letterSpacing: -0.1,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // 価格とカートボタン
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // 価格
                          Text(
                            '¥${burger.price.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFFFF6B9D),
                              letterSpacing: -0.5,
                            ),
                          ),
                          // カートボタン
                          if (onAddToCart != null)
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFF6B9D),
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFFF6B9D)
                                        .withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: onAddToCart,
                                  borderRadius: BorderRadius.circular(8),
                                  child: const Icon(
                                    Icons.add_rounded,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}