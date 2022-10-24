import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woocommerce_case/placeholder_data.dart';
import 'package:woocommerce_case/providers/pageview_provider.dart';
import 'package:woocommerce_case/woocom_api.dart';

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
        Text(cacheList.toString()),
        ElevatedButton(
            onPressed: () async {
              await WooComApi.wc
                  .post('products', PlaceHolder.data)
                  .whenComplete(
                      () => ref.read(pageviewProvider.notifier).state = 0);
            },
            child: const Text('Veriyi Ekle')),
      ],
    );
  }
}
