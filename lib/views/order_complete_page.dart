// Flutter のコアパッケージ
import 'package:flutter/material.dart';

// 注文完了ページ: 注文が完了したことを表示する画面
// ユーザーに注文の完了を通知し、配達予定時間や注文番号を表示する
class OrderCompletePage extends StatelessWidget {
  const OrderCompletePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold: Material Design の基本的なレイアウト構造を提供
    return Scaffold(
      backgroundColor: Colors.white,
      // SafeArea: ノッチやステータスバーの領域を避けてコンテンツを表示
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Spacer: 利用可能なスペースを埋める（上部の余白として使用）
              const Spacer(),
              // 成功アイコン（チェックマーク付きの丸いアイコン）
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF6B9D),  // ピンク色の背景
                  shape: BoxShape.circle,          // 円形
                ),
                child: const Icon(
                  Icons.check_rounded,               // チェックマークアイコン
                  size: 60,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 32),

              // タイトル（注文完了）
              Text(
                '注文完了',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: Colors.grey.shade900,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 16),

              // メッセージ（ユーザーへの感謝とお知らせ）
              Text(
                'ご注文ありがとうございます\n美味しいバーガーをお楽しみに！',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                  height: 1.6,  // 行間の高さ
                ),
                textAlign: TextAlign.center,  // テキストを中央揃え
              ),
              const SizedBox(height: 48),

              // 注文情報（配達予定時間と注文番号を表示）
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),  // 角丸
                  border: Border.all(
                    color: Colors.grey.shade200,
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    // 配達予定時間の行
                    _buildInfoRow(
                      Icons.access_time_rounded,
                      '配達予定',
                      '30〜40分',
                    ),
                    const SizedBox(height: 20),
                    // 区切り線
                    Container(
                      height: 1,
                      color: Colors.grey.shade200,
                    ),
                    const SizedBox(height: 20),
                    // 注文番号の行
                    // DateTime.now().millisecondsSinceEpoch: 現在時刻のミリ秒（エポックからの経過時間）
                    // % 10000: 下4桁を取得して注文番号として使用（簡易的な実装）
                    _buildInfoRow(
                      Icons.receipt_long_rounded,
                      '注文番号',
                      '#${DateTime.now().millisecondsSinceEpoch % 10000}',
                    ),
                  ],
                ),
              ),
              const Spacer(),

              // ホームに戻るボタン
              SizedBox(
                width: double.infinity,  // 幅を親ウィジェットいっぱいに広げる
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigator.of(context).popUntil: 条件を満たすまで画面を戻る
                    // route.isFirst: ルートスタックの最初の画面（MainPage）まで戻る
                    // つまり、すべての画面をポップしてホーム画面に戻る
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade900,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'ホームに戻る',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 情報行を構築するヘルパーメソッド
  // icon: 表示するアイコン、label: ラベルテキスト、value: 値テキスト
  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        // アイコン
        Icon(
          icon,
          color: const Color(0xFFFF6B9D),
          size: 24,
        ),
        const SizedBox(width: 16),
        // ラベルと値を縦に並べる
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ラベル（小さめのグレーのテキスト）
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              // 値（大きめの太字のテキスト）
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade900,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
