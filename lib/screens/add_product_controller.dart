import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monahawk_woocommerce/woocommerce.dart';
import 'package:woocommerce_case/infrastructure/woocom_api.dart';

final addProductControllerProvider =
    StateNotifierProvider.autoDispose<AddProductController, AsyncValue<void>>(
        (ref) =>
            AddProductController(wooCommerce: ref.watch(wooCommerceProvider)));

class AddProductController extends StateNotifier<AsyncValue<void>> {
  AddProductController({required this.wooCommerce})
      : super(const AsyncData<void>(null));

  final WooCommerce wooCommerce;

  Future<void> postProduct(Map<String, dynamic> data) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard<void>(
      () => wooCommerce.post('products', data),
    );
  }
}
