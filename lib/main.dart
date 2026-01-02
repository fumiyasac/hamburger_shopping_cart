// Flutter のコアパッケージ
import 'package:flutter/material.dart';
// Riverpod パッケージ（状態管理ライブラリ）
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Google Fonts パッケージ（カスタムフォント利用）
import 'package:google_fonts/google_fonts.dart';
// メインページのインポート
import 'views/main_page.dart';

// アプリケーションのエントリーポイント（起動時に最初に実行される関数）
void main() {
  // runApp() で Flutter アプリを起動
  runApp(
    // ProviderScope は Riverpod を使うために必要なウィジェット
    // アプリ全体を ProviderScope で囲むことで、どこからでもプロバイダーにアクセスできる
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

// アプリケーションのルートウィジェット
// StatelessWidget: 状態を持たない（変化しない）ウィジェット
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // build メソッド: UI を構築するメソッド
  // context: ウィジェットツリー内の位置情報を持つオブジェクト
  @override
  Widget build(BuildContext context) {
    // MaterialApp: Material Design に基づいたアプリケーションのベースとなるウィジェット
    // ナビゲーションやテーマなどの基本機能を提供する
    return MaterialApp(
      // アプリケーションのタイトル（タスクスイッチャーなどで表示される）
      title: 'Burger Shop',
      // 右上のデバッグバナーを非表示にする
      debugShowCheckedModeBanner: false,
      // アプリ全体のテーマ設定
      theme: ThemeData(
        // カラースキーム: アプリ全体の色の組み合わせを定義
        // fromSeed を使うと、1つの色から調和の取れた色のセットを自動生成
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF6B9D), // ピンク色をベースカラーとして設定
          primary: const Color(0xFFFF6B9D),   // プライマリカラー（主要な色）
        ),
        // Material Design 3 を有効にする（最新のデザインシステム）
        useMaterial3: true,
        // Google Fonts の Noto Sans フォントをアプリ全体のテキストテーマとして設定
        textTheme: GoogleFonts.notoSansTextTheme(),
        // Scaffold の背景色を白に設定
        scaffoldBackgroundColor: Colors.white,
      ),
      // アプリ起動時に表示される最初のページ
      home: const MainPage(),
    );
  }
}