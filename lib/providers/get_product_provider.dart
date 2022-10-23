import 'package:monahawk_woocommerce/models/products.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:woocommerce_case/woocom_api.dart';

part 'get_product_provider.g.dart';

@riverpod
Future<WooProduct> getProduct(GetProductRef ref, {required int? id}) async {
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
}
