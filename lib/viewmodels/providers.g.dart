// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$burgerRepositoryHash() => r'b78024368bcb4bfa6d058cfc97d7f014c1cfe3a3';

/// See also [burgerRepository].
@ProviderFor(burgerRepository)
final burgerRepositoryProvider = AutoDisposeProvider<BurgerRepository>.internal(
  burgerRepository,
  name: r'burgerRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$burgerRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BurgerRepositoryRef = AutoDisposeProviderRef<BurgerRepository>;
String _$cartRepositoryHash() => r'b28615442f9cdf5a3ee149f4a1c2552ef9b49319';

/// See also [cartRepository].
@ProviderFor(cartRepository)
final cartRepositoryProvider = AutoDisposeProvider<CartRepository>.internal(
  cartRepository,
  name: r'cartRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cartRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CartRepositoryRef = AutoDisposeProviderRef<CartRepository>;
String _$cartTotalHash() => r'7270b0e49fcf866e9a223f57799c372f1dd99757';

/// See also [cartTotal].
@ProviderFor(cartTotal)
final cartTotalProvider = AutoDisposeFutureProvider<double>.internal(
  cartTotal,
  name: r'cartTotalProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cartTotalHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CartTotalRef = AutoDisposeFutureProviderRef<double>;
String _$cartItemCountHash() => r'63a590c26e959fb32ea3664cc52faec02ae3046f';

/// See also [cartItemCount].
@ProviderFor(cartItemCount)
final cartItemCountProvider = AutoDisposeFutureProvider<int>.internal(
  cartItemCount,
  name: r'cartItemCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cartItemCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CartItemCountRef = AutoDisposeFutureProviderRef<int>;
String _$burgerListHash() => r'ec4e886892df39533836506fc920f935c80ba292';

/// See also [BurgerList].
@ProviderFor(BurgerList)
final burgerListProvider =
    AutoDisposeAsyncNotifierProvider<BurgerList, List<Burger>>.internal(
      BurgerList.new,
      name: r'burgerListProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$burgerListHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$BurgerList = AutoDisposeAsyncNotifier<List<Burger>>;
String _$burgerSearchHash() => r'50bc8b54221a070d4c95a2073de0c4e0d4c09636';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$BurgerSearch
    extends BuildlessAutoDisposeAsyncNotifier<List<Burger>> {
  late final String query;

  FutureOr<List<Burger>> build(String query);
}

/// See also [BurgerSearch].
@ProviderFor(BurgerSearch)
const burgerSearchProvider = BurgerSearchFamily();

/// See also [BurgerSearch].
class BurgerSearchFamily extends Family<AsyncValue<List<Burger>>> {
  /// See also [BurgerSearch].
  const BurgerSearchFamily();

  /// See also [BurgerSearch].
  BurgerSearchProvider call(String query) {
    return BurgerSearchProvider(query);
  }

  @override
  BurgerSearchProvider getProviderOverride(
    covariant BurgerSearchProvider provider,
  ) {
    return call(provider.query);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'burgerSearchProvider';
}

/// See also [BurgerSearch].
class BurgerSearchProvider
    extends AutoDisposeAsyncNotifierProviderImpl<BurgerSearch, List<Burger>> {
  /// See also [BurgerSearch].
  BurgerSearchProvider(String query)
    : this._internal(
        () => BurgerSearch()..query = query,
        from: burgerSearchProvider,
        name: r'burgerSearchProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$burgerSearchHash,
        dependencies: BurgerSearchFamily._dependencies,
        allTransitiveDependencies:
            BurgerSearchFamily._allTransitiveDependencies,
        query: query,
      );

  BurgerSearchProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
  }) : super.internal();

  final String query;

  @override
  FutureOr<List<Burger>> runNotifierBuild(covariant BurgerSearch notifier) {
    return notifier.build(query);
  }

  @override
  Override overrideWith(BurgerSearch Function() create) {
    return ProviderOverride(
      origin: this,
      override: BurgerSearchProvider._internal(
        () => create()..query = query,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<BurgerSearch, List<Burger>>
  createElement() {
    return _BurgerSearchProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BurgerSearchProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin BurgerSearchRef on AutoDisposeAsyncNotifierProviderRef<List<Burger>> {
  /// The parameter `query` of this provider.
  String get query;
}

class _BurgerSearchProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<BurgerSearch, List<Burger>>
    with BurgerSearchRef {
  _BurgerSearchProviderElement(super.provider);

  @override
  String get query => (origin as BurgerSearchProvider).query;
}

String _$cartHash() => r'93aab2b812cf03aea750732f8dac69773d64c29d';

/// See also [Cart].
@ProviderFor(Cart)
final cartProvider =
    AutoDisposeAsyncNotifierProvider<Cart, List<CartItem>>.internal(
      Cart.new,
      name: r'cartProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$cartHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$Cart = AutoDisposeAsyncNotifier<List<CartItem>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
