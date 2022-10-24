import 'package:monahawk_woocommerce/models/products.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:woocommerce_case/woocom_api.dart';
part 'get_products_provider.g.dart';

@riverpod
Future<List<WooProduct>> getProducts(
  GetProductsRef ref,
) async {
  final json = await WooComApi.wc.getProducts(perPage: 100);
  //parse json to Product List and return
  print(json.length);
  return json;
}
