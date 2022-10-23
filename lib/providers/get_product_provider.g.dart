// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_product_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// ignore_for_file: avoid_private_typedef_functions, non_constant_identifier_names, subtype_of_sealed_class, invalid_use_of_internal_member, unused_element, constant_identifier_names, unnecessary_raw_strings, library_private_types_in_public_api

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

String $getProductHash() => r'b49a2c8ac9fc2abf97a7702739051fac62c19647';

/// See also [getProduct].
class GetProductProvider extends AutoDisposeFutureProvider<WooProduct> {
  GetProductProvider({
    required this.id,
  }) : super(
          (ref) => getProduct(
            ref,
            id: id,
          ),
          from: getProductProvider,
          name: r'getProductProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $getProductHash,
        );

  final int? id;

  @override
  bool operator ==(Object other) {
    return other is GetProductProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef GetProductRef = AutoDisposeFutureProviderRef<WooProduct>;

/// See also [getProduct].
final getProductProvider = GetProductFamily();

class GetProductFamily extends Family<AsyncValue<WooProduct>> {
  GetProductFamily();

  GetProductProvider call({
    required int? id,
  }) {
    return GetProductProvider(
      id: id,
    );
  }

  @override
  AutoDisposeFutureProvider<WooProduct> getProviderOverride(
    covariant GetProductProvider provider,
  ) {
    return call(
      id: provider.id,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'getProductProvider';
}
