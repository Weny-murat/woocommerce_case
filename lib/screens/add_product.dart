import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woocommerce_case/models/placeholder_data.dart';
import 'package:woocommerce_case/providers/pageview_provider.dart';
import 'package:woocommerce_case/infrastructure/woocom_api.dart';
import 'package:woocommerce_case/providers/product_list_provider.dart';

class AddProduct extends ConsumerWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var cacheList = List.empty(growable: true);
    PlaceHolder.data.forEach((key, value) {
      cacheList.add(value);
    });
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(cacheList.toString()),
        ),
        ElevatedButton(
            onPressed: () async {
              await WooComApi.wc
                  .post('products', PlaceHolder.data)
                  .whenComplete(
                      () => ref.read(pageviewProvider.notifier).state = 2)
                  .whenComplete(() => ref.refresh(productListProvider))
                  .whenComplete(() => PlaceHolder.pageController.animateToPage(
                      2,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease));
            },
            child: const Text('Veriyi Ekle')),
      ],
    );
  }
}
