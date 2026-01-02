import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/providers.dart';
import '../widgets/burger_card.dart';
import 'burger_detail_page.dart';

// ホームページ: バーガーのリストをグリッド表示する画面
// ConsumerWidget: Riverpod のプロバイダーにアクセスできる StatelessWidget
// 状態を持たず、プロバイダーから取得したデータを表示するだけのウィジェット
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  // build メソッド: UI を構築
  // WidgetRef ref: プロバイダーにアクセスするためのオブジェクト
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // バーガーリストを監視（AsyncValue で非同期の状態を扱う）
    final burgersAsync = ref.watch(burgerListProvider);
    // カートプロバイダーの notifier を取得（カートへの追加などの操作を行う）
    // ref.read: 値を一度だけ読み取る（変更を監視しない）
    final cartNotifier = ref.read(cartProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          'BURGER SHOP',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
            fontSize: 18,
            color: Colors.grey.shade900,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            color: Colors.grey.shade200,
          ),
        ),
      ),
      // when メソッド: AsyncValue の状態（data, loading, error）に応じて異なる UI を表示
      // これにより、ローディング中やエラー時の UI を簡単に実装できる
      body: burgersAsync.when(
        // data: データの取得が成功した場合
        data: (burgers) {
          // RefreshIndicator: 引っ張って更新（Pull to Refresh）機能を提供
          return RefreshIndicator(
            // onRefresh: 引っ張って更新した時に呼ばれるコールバック
            onRefresh: () async {
              await ref.read(burgerListProvider.notifier).refresh();
            },
            color: const Color(0xFFFF6B9D),  // インジケーターの色
            // GridView.builder: グリッド表示（格子状のレイアウト）
            // builder を使うことで、必要な分だけアイテムを生成（パフォーマンス向上）
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.68,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: burgers.length,
              itemBuilder: (context, index) {
                final burger = burgers[index];
                return BurgerCard(
                  burger: burger,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BurgerDetailPage(burger: burger),
                      ),
                    );
                  },
                  onAddToCart: () async {
                    await cartNotifier.addToCart(burger);
                    if (context.mounted) {
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
                              Expanded(
                                child: Text(
                                  'カートに追加しました',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          backgroundColor: Colors.grey.shade900,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          duration: const Duration(seconds: 2),
                          margin: const EdgeInsets.all(16),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          );
        },
        // loading: データの取得中（ローディング状態）
        loading: () => Center(
          // CircularProgressIndicator: くるくる回るローディングインジケーター
          child: CircularProgressIndicator(
            color: Colors.grey.shade400,
            strokeWidth: 2,  // インジケーターの線の太さ
          ),
        ),
        // error: データの取得に失敗した場合
        // error: エラーオブジェクト、stack: スタックトレース
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline_rounded,
                size: 60,
                color: Colors.grey.shade400,
              ),
              const SizedBox(height: 16),
              Text(
                'エラーが発生しました',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  ref.invalidate(burgerListProvider);
                },
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFFFF6B9D),
                ),
                child: const Text('再読み込み'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}