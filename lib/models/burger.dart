class Burger {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final List<String> ingredients;
  final int calories;
  final String recommendComment;  // お店からのおすすめコメント
  final List<String> allergens;   // アレルギー情報
  final List<CustomerReview> customerReviews;  // お客様の声

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
    return Burger(
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

class CustomerReview {
  final String userName;
  final double rating;  // 1.0 - 5.0
  final String comment;
  final String date;

  CustomerReview({
    required this.userName,
    required this.rating,
    required this.comment,
    required this.date,
  });
}