import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/providers.dart';
import 'home_page.dart';
import 'search_page.dart';
import 'cart_page.dart';

// メインページ: ボトムナビゲーションバーで3つのページを切り替える画面
// ConsumerStatefulWidget: Riverpod で状態管理を使う StatefulWidget
// 状態を持ち、かつ Riverpod のプロバイダーにアクセスできる
class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

// State クラス
class _MainPageState extends ConsumerState<MainPage> {
  // 現在選択されているタブのインデックス（0: ホーム, 1: 検索, 2: カート）
  int _selectedIndex = 0;

  // 表示するページのリスト
  // インデックスに対応するページウィジェットを保持
  final List<Widget> _pages = const [
    HomePage(),      // インデックス 0
    SearchPage(),    // インデックス 1
    CartPage(),      // インデックス 2
  ];

  @override
  Widget build(BuildContext context) {
    // ref.watch: プロバイダーを監視し、値が変わったら自動的に再描画
    // カート内のアイテム数を取得（バッジ表示用）
    final cartItemCountAsync = ref.watch(cartItemCountProvider);

    // Scaffold: Material Design の基本的なレイアウト構造を提供
    return Scaffold(
      // IndexedStack: 複数の子ウィジェットを重ねて表示し、index で指定した1つだけを表示
      // 他のウィジェットは非表示だが、状態は保持される（ページ遷移時に状態がリセットされない）
      body: IndexedStack(
        index: _selectedIndex,  // 表示するページのインデックス
        children: _pages,       // 表示するページのリスト
      ),
      // ボトムナビゲーションバー
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  icon: Icons.home_rounded,
                  label: 'ホーム',
                  index: 0,
                ),
                _buildNavItem(
                  icon: Icons.search_rounded,
                  label: '検索',
                  index: 1,
                ),
                _buildNavItem(
                  icon: Icons.shopping_cart_rounded,
                  label: 'カート',
                  index: 2,
                  badge: cartItemCountAsync.when(
                    data: (count) => count > 0 ? count : null,
                    loading: () => null,
                    error: (_, __) => null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ナビゲーションアイテムを構築するヘルパーメソッド
  // icon: アイコン、label: ラベル、index: タブのインデックス、badge: バッジの数字（オプション）
  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    int? badge,  // null 許容型: バッジがない場合は null
  }) {
    // このアイテムが選択されているかどうか
    final isSelected = _selectedIndex == index;

    // Expanded: 親ウィジェットの利用可能なスペースを均等に分割して占有
    return Expanded(
      // GestureDetector: タップなどのジェスチャーを検出
      child: GestureDetector(
        // タップされた時の処理
        onTap: () {
          // setState: 状態を更新して UI を再描画
          setState(() {
            _selectedIndex = index;  // 選択されたインデックスを更新
          });
        },
        // HitTestBehavior.opaque: タップ可能な領域を広げる（透明な部分もタップ可能に）
        behavior: HitTestBehavior.opaque,
        child: Container(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                    icon,
                    color: isSelected
                        ? const Color(0xFFFF6B9D)
                        : Colors.grey.shade400,
                    size: 26,
                  ),
                  if (badge != null)
                    Positioned(
                      right: -8,
                      top: -4,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Color(0xFFFF6B9D),
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 18,
                          minHeight: 18,
                        ),
                        child: Center(
                          child: Text(
                            badge > 99 ? '99+' : badge.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected
                      ? const Color(0xFFFF6B9D)
                      : Colors.grey.shade500,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}