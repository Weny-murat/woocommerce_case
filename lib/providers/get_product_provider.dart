import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monahawk_woocommerce/models/products.dart';
import 'package:woocommerce_case/infrastructure/woocom_api.dart';

final productIdProvider = StateProvider<int>((ref) {
  return 0;
});

final productProvider = FutureProvider<WooProduct>((
  ref,
) async {
  int id = ref.watch(productIdProvider);
  try {
    final json = await WooComApi.wc
        .get('products/$id')
        .then((value) => WooProduct.fromJson(value));
    return json;
  } catch (e) {
    return WooProduct(
        id,
        'Lütfen geçerli bir ürün id\'si girerek arama yapınız',
        '',
        '',
        '',
        '',
        false,
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        false,
        false,
        0,
        false,
        false,
        [],
        0,
        0,
        '',
        '',
        '',
        '',
        false,
        0,
        '',
        '',
        false,
        false,
        false,
        '',
        WooProductDimension('0', '0', '0'),
        false,
        false,
        '',
        0,
        false,
        '',
        0,
        [],
        [],
        [],
        0,
        '',
        [],
        [],
        [],
        [],
        [],
        [],
        [],
        0,
        []);
  }
});
