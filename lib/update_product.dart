import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woocommerce_case/providers/get_product_provider.dart';
import 'package:woocommerce_case/woocom_api.dart';

class UpdateProduct extends ConsumerStatefulWidget {
  const UpdateProduct({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UpdateProductState();
}

class _UpdateProductState extends ConsumerState<UpdateProduct> {
  @override
  Widget build(BuildContext context) {
    var productAsync = ref.watch(productProvider);
    TextEditingController textController = TextEditingController();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextFormField(
            controller: textController,
            decoration: const InputDecoration(
              hintText: 'Ürün ID',
            ),
          ),
        ),
        ElevatedButton(
            onPressed: () async {
              try {
                ref.read(productIdProvider.notifier).state =
                    int.parse(textController.text);
              } catch (e) {
                ref.read(productIdProvider.notifier).state = 0;
              }
            },
            child: const Text('Ürün Ara')),
        productAsync.when(
          data: (data) {
            return Column(
              children: [
                Text('Ürün id: ${data.id}'),
                Text(data.name ?? 'İsim Verisi Yok'),
                Text(data.price ?? 'Fiyat Verisi Yok'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: data.id == 0
                          ? null
                          : () async {
                              await WooComApi.wc
                                  .put('products/${data.id}', null);
                            },
                      child: const Text('Güncelle'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: data.id == 0
                          ? null
                          : () async {
                              await WooComApi.wc
                                  .delete('products/${data.id}', {});
                            },
                      child: const Text('Sil'),
                    ),
                  ],
                ),
              ],
            );
          },
          error: (error, stackTrace) => const Text('Bir Sorun Var'),
          loading: () => const CircularProgressIndicator(),
        ),
      ],
    );
  }
}
