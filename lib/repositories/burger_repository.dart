import '../models/burger.dart';

class BurgerRepository {
  // モックデータ
  final List<Burger> _mockBurgers = [
    Burger(
      id: '1',
      name: 'クラシックバーガー🍔',
      description: '定番の美味しさ！100%ビーフパティをジューシーに焼き上げ、新鮮なレタス、完熟トマト、シャキシャキのオニオンをサンドしました。シンプルだからこそ素材の美味しさが際立つ王道バーガーです。',
      price: 580,
      imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400',
      ingredients: ['ビーフパティ', 'レタス', 'トマト', 'オニオン', 'チーズ'],
      calories: 520,
      recommendComment: '当店一番の人気商品！初めての方にはまずこれをお試しください。シンプルながら完成度の高い味わいで、リピーター続出中です。',
      allergens: ['小麦', '乳', '牛肉'],
      customerReviews: [
        CustomerReview(
          userName: '田中さん',
          rating: 5.0,
          comment: 'シンプルで美味しい！パティがジューシーで最高です。',
          date: '2024-12-15',
        ),
        CustomerReview(
          userName: '佐藤さん',
          rating: 4.5,
          comment: '定番の味で安心感があります。何度も注文しています。',
          date: '2024-12-10',
        ),
      ],
    ),
    Burger(
      id: '2',
      name: 'チーズバーガー🧀',
      description: 'とろ〜りチーズがたっぷり！厳選されたチェダーチーズとモッツァレラチーズのダブル使いで、濃厚なチーズの風味が口いっぱいに広がります。チーズ好きにはたまらない一品です。',
      price: 680,
      imageUrl: 'https://images.unsplash.com/photo-1550547660-d9450f859349?w=400',
      ingredients: ['ビーフパティ', 'ダブルチーズ', 'レタス', 'トマト'],
      calories: 620,
      recommendComment: 'チーズ好き必見！2種類のチーズを贅沢に使用した濃厚な味わいが自慢です。温かいうちにお召し上がりください。',
      allergens: ['小麦', '乳', '牛肉'],
      customerReviews: [
        CustomerReview(
          userName: '鈴木さん',
          rating: 5.0,
          comment: 'チーズが最高！とろとろで美味しいです。',
          date: '2024-12-18',
        ),
        CustomerReview(
          userName: '山田さん',
          rating: 4.8,
          comment: 'チーズの量がちょうどいい。濃厚で満足感があります。',
          date: '2024-12-12',
        ),
      ],
    ),
    Burger(
      id: '3',
      name: 'ベーコンバーガー🥓',
      description: 'カリカリベーコンがアクセント！厳選した豚バラ肉をカリッと香ばしく焼き上げたベーコンと、ジューシーなビーフパティの絶妙なハーモニー。濃厚な旨味とスモーキーな香りが食欲をそそります。',
      price: 750,
      imageUrl: 'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=400',
      ingredients: ['ビーフパティ', 'ベーコン', 'チーズ', 'レタス', 'トマト'],
      calories: 680,
      recommendComment: 'カリカリベーコンの食感がたまらない！スモーキーな香りが食欲をそそります。がっつり食べたい時におすすめです。',
      allergens: ['小麦', '乳', '牛肉', '豚肉'],
      customerReviews: [
        CustomerReview(
          userName: '高橋さん',
          rating: 5.0,
          comment: 'ベーコンがカリカリで最高！ボリュームもたっぷりです。',
          date: '2024-12-16',
        ),
        CustomerReview(
          userName: '伊藤さん',
          rating: 4.7,
          comment: 'スモーキーな香りがクセになる。リピート確定です。',
          date: '2024-12-14',
        ),
      ],
    ),
    Burger(
      id: '4',
      name: 'テリヤキバーガー🍖',
      description: '甘辛テリヤキソースがクセになる！醤油ベースの特製テリヤキソースで味付けした和風バーガー。マヨネーズのまろやかさとテリヤキの甘辛さが絶妙にマッチし、日本人好みの味わいに仕上げました。',
      price: 720,
      imageUrl: 'https://images.unsplash.com/photo-1603064752734-4c48eff53d05?w=400',
      ingredients: ['ビーフパティ', 'テリヤキソース', 'レタス', 'マヨネーズ'],
      calories: 590,
      recommendComment: '和風の味付けが日本人の心をつかむ！甘辛いテリヤキソースとマヨネーズの組み合わせは絶品です。',
      allergens: ['小麦', '乳', '牛肉', '大豆', '卵'],
      customerReviews: [
        CustomerReview(
          userName: '中村さん',
          rating: 4.9,
          comment: '和風で食べやすい！テリヤキソースが絶妙です。',
          date: '2024-12-17',
        ),
        CustomerReview(
          userName: '小林さん',
          rating: 4.6,
          comment: '甘辛いタレがご飯にも合いそう。美味しいです。',
          date: '2024-12-11',
        ),
      ],
    ),
    Burger(
      id: '5',
      name: 'アボカドバーガー🥑',
      description: 'ヘルシー派にオススメ！クリーミーで栄養価の高いアボカドをたっぷりトッピング。森のバターと呼ばれるアボカドの濃厚な味わいと、フレッシュ野菜のシャキシャキ食感が楽しめる、美容と健康を気遣う方に最適なバーガーです。',
      price: 850,
      imageUrl: 'https://images.unsplash.com/photo-1572802419224-296b0aeee0d9?w=400',
      ingredients: ['ビーフパティ', 'アボカド', 'レタス', 'トマト', 'チーズ'],
      calories: 650,
      recommendComment: '女性に大人気！栄養満点のアボカドを使用した、美容にも嬉しいヘルシーバーガーです。クリーミーな食感をお楽しみください。',
      allergens: ['小麦', '乳', '牛肉'],
      customerReviews: [
        CustomerReview(
          userName: '渡辺さん',
          rating: 4.8,
          comment: 'アボカドがクリーミーで美味しい！ヘルシーなのも嬉しい。',
          date: '2024-12-19',
        ),
        CustomerReview(
          userName: '松本さん',
          rating: 4.5,
          comment: '野菜たっぷりで罪悪感なく食べられます。',
          date: '2024-12-13',
        ),
      ],
    ),
    Burger(
      id: '6',
      name: 'スパイシーバーガー🌶️',
      description: 'ピリ辛好きにはたまらない！ハラペーニョと特製スパイシーソースでパンチの効いた味わいに。刺激的な辛さの中にも旨味がしっかりと感じられ、一度食べたらやみつきになること間違いなし。辛いもの好き必食の一品です。',
      price: 780,
      imageUrl: 'https://images.unsplash.com/photo-1585238341710-4a8e9c1d5e1f?w=400',
      ingredients: ['ビーフパティ', 'ハラペーニョ', 'スパイシーソース', 'レタス'],
      calories: 610,
      recommendComment: '辛党必見！ハラペーニョの刺激がクセになります。辛さの中にも旨味があり、ビールとの相性も抜群です。',
      allergens: ['小麦', '乳', '牛肉'],
      customerReviews: [
        CustomerReview(
          userName: '井上さん',
          rating: 5.0,
          comment: '辛さがちょうどいい！スパイシーで美味しいです。',
          date: '2024-12-18',
        ),
        CustomerReview(
          userName: '木村さん',
          rating: 4.7,
          comment: 'ピリ辛でやみつきになる味。リピート決定！',
          date: '2024-12-15',
        ),
      ],
    ),
    Burger(
      id: '7',
      name: 'ダブルバーガー🍔🍔',
      description: 'がっつり食べたい方に！100%ビーフパティを2枚重ねた超ボリューム満点バーガー。肉の旨味が2倍になり、食べ応え抜群。チーズとの相性も完璧で、満足度MAXの一品。お腹を空かせて挑んでください！',
      price: 980,
      imageUrl: 'https://images.unsplash.com/photo-1553979459-d2229ba7433b?w=400',
      ingredients: ['ダブルパティ', 'チーズ', 'レタス', 'トマト', 'オニオン'],
      calories: 890,
      recommendComment: '圧倒的ボリューム！パティ2枚でお腹いっぱい間違いなし。がっつり食べたい時の最強の選択です。',
      allergens: ['小麦', '乳', '牛肉'],
      customerReviews: [
        CustomerReview(
          userName: '加藤さん',
          rating: 5.0,
          comment: 'ボリューム満点！お腹いっぱいになりました。',
          date: '2024-12-17',
        ),
        CustomerReview(
          userName: '吉田さん',
          rating: 4.9,
          comment: 'パティ2枚は最高！満足度が高いです。',
          date: '2024-12-14',
        ),
      ],
    ),
    Burger(
      id: '8',
      name: 'フィッシュバーガー🐟',
      description: 'サクサク白身魚のフライが絶品！新鮮な白身魚を特製の衣でカラッと揚げ、タルタルソースとの相性抜群。魚好きはもちろん、肉が苦手な方にもおすすめの優しい味わい。ヘルシーで軽い口当たりが人気です。',
      price: 650,
      imageUrl: 'https://images.unsplash.com/photo-1619780462570-46f0e1cfb9dd?w=400',
      ingredients: ['白身魚フライ', 'タルタルソース', 'レタス', 'チーズ'],
      calories: 480,
      recommendComment: 'お魚好きの方へ！サクサクの衣とタルタルソースの相性が抜群。ヘルシーで食べやすい一品です。',
      allergens: ['小麦', '乳', '魚', '卵'],
      customerReviews: [
        CustomerReview(
          userName: '斎藤さん',
          rating: 4.6,
          comment: 'タルタルソースが美味しい！魚も新鮮です。',
          date: '2024-12-16',
        ),
        CustomerReview(
          userName: '清水さん',
          rating: 4.4,
          comment: 'サクサクで軽い。ヘルシーで嬉しいです。',
          date: '2024-12-12',
        ),
      ],
    ),
    Burger(
      id: '9',
      name: 'チキンバーガー🐔',
      description: 'ジューシーなチキンパティが自慢！鶏むね肉を使用し、外はカリッと中はジューシーに焼き上げました。ヘルシーながらも満足感たっぷりで、あっさりとした味わいが後を引きます。女性にも大人気の一品です。',
      price: 680,
      imageUrl: 'https://images.unsplash.com/photo-1606755962773-d324e0a13086?w=400',
      ingredients: ['チキンパティ', 'レタス', 'トマト', 'マヨネーズ'],
      calories: 550,
      recommendComment: 'ヘルシー志向の方に！鶏むね肉を使用したジューシーなパティは、カロリー控えめでも満足感たっぷりです。',
      allergens: ['小麦', '乳', '鶏肉', '卵'],
      customerReviews: [
        CustomerReview(
          userName: '森さん',
          rating: 4.7,
          comment: 'チキンがジューシー！ヘルシーで美味しいです。',
          date: '2024-12-18',
        ),
        CustomerReview(
          userName: '池田さん',
          rating: 4.5,
          comment: 'あっさりしていて食べやすい。リピートします。',
          date: '2024-12-11',
        ),
      ],
    ),
    Burger(
      id: '10',
      name: 'ベジバーガー🥗',
      description: '野菜たっぷりヘルシー志向！大豆ミートを使用した植物性パティに、新鮮な野菜をふんだんにサンド。カロリー控えめでありながら栄養バランスも完璧。ベジタリアンの方にも、ダイエット中の方にもおすすめの罪悪感ゼロバーガーです。',
      price: 720,
      imageUrl: 'https://images.unsplash.com/photo-1520072959219-c595dc870360?w=400',
      ingredients: ['野菜パティ', 'レタス', 'トマト', 'アボカド', 'オニオン'],
      calories: 420,
      recommendComment: 'ベジタリアンの方も安心！大豆ミート使用で栄養満点。野菜の美味しさを存分に味わえるヘルシーバーガーです。',
      allergens: ['小麦', '大豆'],
      customerReviews: [
        CustomerReview(
          userName: '藤田さん',
          rating: 4.8,
          comment: 'ヘルシーで美味しい！野菜がたっぷりで嬉しい。',
          date: '2024-12-19',
        ),
        CustomerReview(
          userName: '橋本さん',
          rating: 4.6,
          comment: 'カロリー低めで罪悪感なし。野菜が新鮮です。',
          date: '2024-12-13',
        ),
      ],
    ),
  ];

  Future<List<Burger>> getAllBurgers() async {
    // 実際のAPIコールをシミュレート
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockBurgers;
  }

  Future<Burger?> getBurgerById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      return _mockBurgers.firstWhere((burger) => burger.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<List<Burger>> searchBurgers(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (query.isEmpty) {
      return _mockBurgers;
    }
    return _mockBurgers.where((burger) {
      return burger.name.toLowerCase().contains(query.toLowerCase()) ||
          burger.description.toLowerCase().contains(query.toLowerCase()) ||
          burger.ingredients.any(
                (ingredient) =>
                ingredient.toLowerCase().contains(query.toLowerCase()),
          );
    }).toList();
  }
}