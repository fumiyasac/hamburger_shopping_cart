// バーガーの情報を表すモデルクラス
// Dart ではクラスを使ってデータ構造を定義する
class Burger {
  // final: 一度設定したら変更できない変数（イミュータブル）
  // イミュータブルにすることで、予期しない値の変更を防ぎ、バグを減らせる
  final String id;                 // バーガーの一意な識別子
  final String name;               // バーガー名
  final String description;        // バーガーの説明文
  final double price;              // 価格（円）
  final String imageUrl;           // 画像の URL
  final List<String> ingredients;  // 材料のリスト
  final int calories;              // カロリー（kcal）
  final String recommendComment;   // お店からのおすすめコメント
  final List<String> allergens;    // アレルギー情報のリスト
  final List<CustomerReview> customerReviews;  // お客様の声のリスト

  // コンストラクタ: Burger オブジェクトを作成する際に呼ばれる
  // required: 必須パラメータ（値を必ず指定しなければならない）
  Burger({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.ingredients,
    required this.calories,
    required this.recommendComment,
    required this.allergens,
    required this.customerReviews,
  });

  // copyWith メソッド: 既存のオブジェクトの一部のフィールドだけを変更した新しいオブジェクトを作成
  // イミュータブルなオブジェクトを扱う際の定石パターン
  // ? 付きの型: null 許容型（値が null でも良い）
  Burger copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    List<String>? ingredients,
    int? calories,
    String? recommendComment,
    List<String>? allergens,
    List<CustomerReview>? customerReviews,
  }) {
    // 新しい Burger オブジェクトを返す
    return Burger(
      // ?? 演算子: null 合体演算子
      // 左側が null なら右側の値を使う
      // つまり、新しい値が渡されたらそれを使い、null なら元の値（this.xxx）を使う
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      ingredients: ingredients ?? this.ingredients,
      calories: calories ?? this.calories,
      recommendComment: recommendComment ?? this.recommendComment,
      allergens: allergens ?? this.allergens,
      customerReviews: customerReviews ?? this.customerReviews,
    );
  }
}

// お客様のレビュー（評価・感想）を表すモデルクラス
class CustomerReview {
  final String userName;  // レビューを書いたユーザー名
  final double rating;    // 評価（1.0 - 5.0 の範囲で星の数を表す）
  final String comment;   // レビューコメント
  final String date;      // レビュー投稿日

  // コンストラクタ
  CustomerReview({
    required this.userName,
    required this.rating,
    required this.comment,
    required this.date,
  });
}