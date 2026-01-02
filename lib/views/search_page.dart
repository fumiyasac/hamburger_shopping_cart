// Flutter のコアパッケージ
import 'package:flutter/material.dart';
// Riverpod（状態管理ライブラリ）
import 'package:flutter_riverpod/flutter_riverpod.dart';
// プロバイダー（状態管理）
import '../viewmodels/providers.dart';
// バーガーカードウィジェット
import '../widgets/burger_card.dart';
// バーガー詳細ページ
import 'burger_detail_page.dart';

// 検索ページ: バーガーを検索し、食材で絞り込む画面
// ConsumerStatefulWidget: 状態を持ち、かつ Riverpod のプロバイダーにアクセスできる
class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

// State クラス: ウィジェットの状態（変更可能なデータ）を管理
class _SearchPageState extends ConsumerState<SearchPage> {
  // TextEditingController: テキストフィールドの入力を制御・監視するコントローラー
  // テキストの取得、設定、リスナーの登録などができる
  final TextEditingController _searchController = TextEditingController();
  // 検索キーワード（ユーザーが入力したテキスト）
  String _searchQuery = '';
  // 選択された食材のリスト（フィルター用）
  List<String> _selectedIngredients = [];

  // dispose: ウィジェットが破棄される時に呼ばれるメソッド
  // メモリリークを防ぐため、使用したリソースを解放する
  @override
  void dispose() {
    // TextEditingController を破棄（メモリを解放）
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 検索結果を監視（検索キーワードが変わると自動的に新しい結果を取得）
    final searchResultsAsync = ref.watch(burgerSearchProvider(_searchQuery));
    // すべての食材のリストを監視
    final allIngredientsAsync = ref.watch(allIngredientsProvider);
    // カートの操作を行うための notifier を取得
    final cartNotifier = ref.read(cartProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          'SEARCH',
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
      body: Column(
        children: [
          // 検索バーとフィルターセクション
          Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 検索バー
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                  // TextField: ユーザーがテキストを入力できるウィジェット
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'バーガーを検索...',
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 15,
                      ),
                      // prefixIcon: テキストフィールドの左側に表示するアイコン
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        color: Colors.grey.shade400,
                        size: 22,
                      ),
                      // suffixIcon: テキストフィールドの右側に表示するアイコン
                      // 検索キーワードがある場合のみクリアボタンを表示
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                        icon: Icon(
                          Icons.close_rounded,
                          color: Colors.grey.shade400,
                          size: 20,
                        ),
                        onPressed: () {
                          // テキストフィールドをクリア
                          _searchController.clear();
                          // 検索キーワードを空にして UI を更新
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                      )
                          : null,  // キーワードがなければボタンを表示しない
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      // border: 枠線のスタイル（BorderSide.none で枠線なし）
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                    // onChanged: テキストが変更される度に呼ばれるコールバック
                    onChanged: (value) {
                      // setState: 状態を更新して UI を再描画
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                ),

                // 食材フィルターセクション
                // allIngredientsAsync.when: 非同期の状態に応じて異なる UI を表示
                allIngredientsAsync.when(
                  // data: データの取得が成功した場合
                  data: (ingredients) {
                    // 食材リストが空の場合は何も表示しない
                    // SizedBox.shrink(): 高さ0のウィジェット（何も表示しない）
                    if (ingredients.isEmpty) return const SizedBox.shrink();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // フィルターのヘッダー
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                          child: Row(
                            children: [
                              Icon(
                                Icons.filter_list_rounded,
                                size: 16,
                                color: Colors.grey.shade600,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '食材で絞り込み',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              // ... 演算子: 条件が true の場合にリストの要素を展開
                              // 選択された食材の数をバッジで表示
                              if (_selectedIngredients.isNotEmpty) ...[
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFF6B9D),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    '${_selectedIngredients.length}',
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                              const Spacer(),
                              // クリアボタン（選択された食材がある場合のみ表示）
                              if (_selectedIngredients.isNotEmpty)
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      // 選択された食材をすべてクリア
                                      _selectedIngredients.clear();
                                    });
                                  },
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 4,
                                    ),
                                    minimumSize: Size.zero,
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: Text(
                                    'クリア',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        // 食材フィルターのチップを横スクロール可能にする
                        // SingleChildScrollView: 子ウィジェットをスクロール可能にする
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,  // 横方向にスクロール
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Wrap(
                            spacing: 8,
                            // 各食材をフィルターチップとして表示
                            children: ingredients.map((ingredient) {
                              final isSelected = _selectedIngredients.contains(ingredient);
                              // FilterChip: 選択可能なチップウィジェット
                              // 選択・解除が可能で、フィルター機能に適している
                              return FilterChip(
                                label: Text(ingredient),
                                selected: isSelected,  // 選択状態
                                // onSelected: チップがタップされた時に呼ばれる
                                onSelected: (selected) {
                                  setState(() {
                                    if (selected) {
                                      // 選択された場合はリストに追加
                                      _selectedIngredients.add(ingredient);
                                    } else {
                                      // 選択解除された場合はリストから削除
                                      _selectedIngredients.remove(ingredient);
                                    }
                                  });
                                },
                                // 未選択時の背景色
                                backgroundColor: Colors.grey.shade100,
                                // 選択時の背景色
                                selectedColor: const Color(0xFFFF6B9D).withOpacity(0.15),
                                // チェックマークの色
                                checkmarkColor: const Color(0xFFFF6B9D),
                                // ラベルのスタイル
                                labelStyle: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected
                                      ? const Color(0xFFFF6B9D)
                                      : Colors.grey.shade700,
                                ),
                                // 枠線のスタイル
                                side: BorderSide(
                                  color: isSelected
                                      ? const Color(0xFFFF6B9D)
                                      : Colors.grey.shade300,
                                  width: 1,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    );
                  },
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                ),

                // 区切り線
                Container(
                  height: 1,
                  color: Colors.grey.shade200,
                ),
              ],
            ),
          ),

          // 検索結果の表示エリア
          Expanded(
            child: searchResultsAsync.when(
              data: (burgers) {
                // 食材フィルターを適用（選択された食材がすべて含まれるバーガーだけに絞り込む）
                var filteredBurgers = burgers;
                if (_selectedIngredients.isNotEmpty) {
                  // where: 条件に一致する要素だけを抽出
                  filteredBurgers = burgers.where((burger) {
                    // every: すべての要素が条件を満たすか確認
                    return _selectedIngredients.every((selectedIngredient) =>
                        // any: いずれかの要素が条件を満たすか確認
                        burger.ingredients.any((burgerIngredient) =>
                            // toLowerCase: 大文字小文字を区別せずに比較
                            burgerIngredient.toLowerCase().contains(selectedIngredient.toLowerCase())));
                  }).toList();
                }

                // 検索結果が0件の場合
                if (filteredBurgers.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // アイコン（検索前と検索結果なしで異なるアイコンを表示）
                        Icon(
                          _searchQuery.isEmpty && _selectedIngredients.isEmpty
                              ? Icons.search_rounded
                              : Icons.search_off_rounded,
                          size: 80,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(height: 16),
                        // メッセージ
                        Text(
                          _searchQuery.isEmpty && _selectedIngredients.isEmpty
                              ? 'バーガーを検索'
                              : '見つかりませんでした',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        // 食材フィルターが適用されている場合の追加メッセージ
                        if (_selectedIngredients.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text(
                            '他の食材で試してみてください',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                }

                // 検索結果が1件以上ある場合
                return Column(
                  children: [
                    // 検索結果数の表示（検索キーワードまたはフィルターがある場合のみ）
                    if (_searchQuery.isNotEmpty || _selectedIngredients.isNotEmpty)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        color: Colors.grey.shade100,
                        child: Text(
                          '${filteredBurgers.length}件のバーガーが見つかりました',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),

                    // グリッド表示（2列で表示）
                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.all(16),
                        // gridDelegate: グリッドのレイアウトを定義
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,            // 列数（2列）
                          childAspectRatio: 0.68,       // アイテムの縦横比
                          crossAxisSpacing: 12,         // 列間の間隔
                          mainAxisSpacing: 12,          // 行間の間隔
                        ),
                        itemCount: filteredBurgers.length,
                        itemBuilder: (context, index) {
                          final burger = filteredBurgers[index];
                          return BurgerCard(
                            burger: burger,
                            // カードがタップされた時の処理
                            onTap: () {
                              // 詳細ページに遷移
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      BurgerDetailPage(burger: burger),
                                ),
                              );
                            },
                            // カートに追加ボタンがタップされた時の処理
                            onAddToCart: () async {
                              await cartNotifier.addToCart(burger);
                              if (context.mounted) {
                                // スナックバーで追加完了を通知
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
                    ),
                  ],
                );
              },
              // loading: データの取得中
              loading: () => Center(
                child: CircularProgressIndicator(
                  color: Colors.grey.shade400,
                  strokeWidth: 2,
                ),
              ),
              // error: データの取得に失敗
              error: (error, stack) => Center(
                child: Icon(
                  Icons.error_outline_rounded,
                  size: 60,
                  color: Colors.grey.shade400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
