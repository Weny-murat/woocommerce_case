import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monahawk_woocommerce/models/products.dart';
import 'package:woocommerce_case/woocom_api.dart';

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
        'name',
        'slug',
        'permalink',
        'type',
        'status',
        false,
        'catalogVisibility',
        'description',
        'shortDescription',
        'sku',
        'price',
        'regularPrice',
        'salePrice',
        'priceHtml',
        false,
        false,
        0,
        false,
        false,
        [],
        0,
        0,
        'externalUrl',
        'buttonText',
        'taxStatus',
        'taxClass',
        false,
        0,
        'stockStatus',
        'backorders',
        false,
        false,
        false,
        'weight',
        WooProductDimension('0', '0', '0'),
        false,
        false,
        'shippingClass',
        0,
        false,
        'averageRating',
        0,
        [],
        [],
        [],
        0,
        'purchaseNote',
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
