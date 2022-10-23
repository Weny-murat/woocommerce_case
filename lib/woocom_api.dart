import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:monahawk_woocommerce/woocommerce.dart';

class WooComApi {
  static String baseUrl = dotenv.env['URL']!;
  static String consumerKey = dotenv.env['CONSUMER_KEY']!;
  static String consumerSecret = dotenv.env['CONSUMER_SECRET_KEY']!;

  static WooCommerce wc = WooCommerce(
    baseUrl: baseUrl,
    consumerKey: consumerKey,
    consumerSecret: consumerSecret,
  );
}
