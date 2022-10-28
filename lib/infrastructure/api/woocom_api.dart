import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monahawk_woocommerce/woocommerce.dart';

class WooComApi {
  static final String baseUrl = dotenv.env['URL']!;
  static final String consumerKey = dotenv.env['CONSUMER_KEY']!;
  static final String consumerSecret = dotenv.env['CONSUMER_SECRET_KEY']!;

  static final WooCommerce wc = WooCommerce(
    baseUrl: baseUrl,
    consumerKey: consumerKey,
    consumerSecret: consumerSecret,
  );
}

final wooCommerceProvider = Provider<WooCommerce>((ref) => WooCommerce(
      baseUrl: dotenv.env['URL']!,
      consumerKey: dotenv.env['CONSUMER_KEY']!,
      consumerSecret: dotenv.env['CONSUMER_SECRET_KEY']!,
    ));
