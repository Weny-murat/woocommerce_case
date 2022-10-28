import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monahawk_woocommerce/models/products.dart';
import 'package:woocommerce_case/infrastructure/api/woocom_api.dart';

final productListPageProvider = StateProvider<int>((ref) {
  return 1;
});

final productListProvider =
    FutureProvider.autoDispose<List<WooProduct>>((ref) async {
  ref.keepAlive();
  int page = ref.watch(productListPageProvider);
  try {
    final json = await WooComApi.wc.getProducts(page: page, perPage: 100);
    return json;
  } catch (e) {
    return [];
  }
});
