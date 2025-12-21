// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(burgerRepository)
const burgerRepositoryProvider = BurgerRepositoryProvider._();

final class BurgerRepositoryProvider
    extends
        $FunctionalProvider<
          BurgerRepository,
          BurgerRepository,
          BurgerRepository
        >
    with $Provider<BurgerRepository> {
  const BurgerRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'burgerRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$burgerRepositoryHash();

  @$internal
  @override
  $ProviderElement<BurgerRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BurgerRepository create(Ref ref) {
    return burgerRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BurgerRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BurgerRepository>(value),
    );
  }
}

String _$burgerRepositoryHash() => r'ed120c40e762267f485e745728136e27a5bf5633';

@ProviderFor(cartRepository)
const cartRepositoryProvider = CartRepositoryProvider._();

final class CartRepositoryProvider
    extends $FunctionalProvider<CartRepository, CartRepository, CartRepository>
    with $Provider<CartRepository> {
  const CartRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cartRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cartRepositoryHash();

  @$internal
  @override
  $ProviderElement<CartRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CartRepository create(Ref ref) {
    return cartRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CartRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CartRepository>(value),
    );
  }
}

String _$cartRepositoryHash() => r'a9887af5870ecc78e9ca65e5564de89c46d2b43c';

@ProviderFor(BurgerList)
const burgerListProvider = BurgerListProvider._();

final class BurgerListProvider
    extends $AsyncNotifierProvider<BurgerList, List<Burger>> {
  const BurgerListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'burgerListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$burgerListHash();

  @$internal
  @override
  BurgerList create() => BurgerList();
}

String _$burgerListHash() => r'ec4e886892df39533836506fc920f935c80ba292';

abstract class _$BurgerList extends $AsyncNotifier<List<Burger>> {
  FutureOr<List<Burger>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<Burger>>, List<Burger>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Burger>>, List<Burger>>,
              AsyncValue<List<Burger>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(allIngredients)
const allIngredientsProvider = AllIngredientsProvider._();

final class AllIngredientsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<String>>,
          List<String>,
          FutureOr<List<String>>
        >
    with $FutureModifier<List<String>>, $FutureProvider<List<String>> {
  const AllIngredientsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allIngredientsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allIngredientsHash();

  @$internal
  @override
  $FutureProviderElement<List<String>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<String>> create(Ref ref) {
    return allIngredients(ref);
  }
}

String _$allIngredientsHash() => r'78863a7fed94653d85fac35484fb0efebc5db692';

@ProviderFor(BurgerSearch)
const burgerSearchProvider = BurgerSearchFamily._();

final class BurgerSearchProvider
    extends $AsyncNotifierProvider<BurgerSearch, List<Burger>> {
  const BurgerSearchProvider._({
    required BurgerSearchFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'burgerSearchProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$burgerSearchHash();

  @override
  String toString() {
    return r'burgerSearchProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  BurgerSearch create() => BurgerSearch();

  @override
  bool operator ==(Object other) {
    return other is BurgerSearchProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$burgerSearchHash() => r'50bc8b54221a070d4c95a2073de0c4e0d4c09636';

final class BurgerSearchFamily extends $Family
    with
        $ClassFamilyOverride<
          BurgerSearch,
          AsyncValue<List<Burger>>,
          List<Burger>,
          FutureOr<List<Burger>>,
          String
        > {
  const BurgerSearchFamily._()
    : super(
        retry: null,
        name: r'burgerSearchProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  BurgerSearchProvider call(String query) =>
      BurgerSearchProvider._(argument: query, from: this);

  @override
  String toString() => r'burgerSearchProvider';
}

abstract class _$BurgerSearch extends $AsyncNotifier<List<Burger>> {
  late final _$args = ref.$arg as String;
  String get query => _$args;

  FutureOr<List<Burger>> build(String query);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<List<Burger>>, List<Burger>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Burger>>, List<Burger>>,
              AsyncValue<List<Burger>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(Cart)
const cartProvider = CartProvider._();

final class CartProvider extends $AsyncNotifierProvider<Cart, List<CartItem>> {
  const CartProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cartProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cartHash();

  @$internal
  @override
  Cart create() => Cart();
}

String _$cartHash() => r'93aab2b812cf03aea750732f8dac69773d64c29d';

abstract class _$Cart extends $AsyncNotifier<List<CartItem>> {
  FutureOr<List<CartItem>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<CartItem>>, List<CartItem>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<CartItem>>, List<CartItem>>,
              AsyncValue<List<CartItem>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(cartTotal)
const cartTotalProvider = CartTotalProvider._();

final class CartTotalProvider
    extends $FunctionalProvider<AsyncValue<double>, double, FutureOr<double>>
    with $FutureModifier<double>, $FutureProvider<double> {
  const CartTotalProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cartTotalProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cartTotalHash();

  @$internal
  @override
  $FutureProviderElement<double> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<double> create(Ref ref) {
    return cartTotal(ref);
  }
}

String _$cartTotalHash() => r'f962e646d01cceadf08d6aec354f1c5839120ed4';

@ProviderFor(cartItemCount)
const cartItemCountProvider = CartItemCountProvider._();

final class CartItemCountProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  const CartItemCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cartItemCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cartItemCountHash();

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    return cartItemCount(ref);
  }
}

String _$cartItemCountHash() => r'ad9c01d455e7a40c4c13f476b6c38c6ea839d9c3';
