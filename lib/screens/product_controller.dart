import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monahawk_woocommerce/woocommerce.dart';
import 'package:woocommerce_case/infrastructure/api/woocom_api.dart';

final productControllerProvider =
    StateNotifierProvider.autoDispose<ProductController, AsyncValue<void>>(
        (ref) =>
            ProductController(wooCommerce: ref.watch(wooCommerceProvider)));

class ProductController extends StateNotifier<AsyncValue<void>> {
  ProductController({required this.wooCommerce})
      : super(const AsyncData<void>(null));

  final WooCommerce wooCommerce;

  Future<void> postProduct(Map<String, dynamic> data) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard<void>(
      () => wooCommerce.post('products', data),
    );
  }

  Future<void> updateProduct({
    required String id,
    required Map<String, dynamic> data,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard<void>(
      () => wooCommerce.put('products/$id', data),
    );
  }

  Future<void> deleteProduct(int id) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard<void>(
      () => wooCommerce.delete('products/$id', {'force': true}),
    );
  }
}
