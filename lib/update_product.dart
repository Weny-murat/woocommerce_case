import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woocommerce_case/providers/get_product_provider.dart';

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
              ref.read(productIdProvider.notifier).state =
                  int.parse(textController.text);
              debugPrint(textController.text);
            },
            child: const Text('Ürün Ara')),
        productAsync.when(
          data: (data) {
            print(data);
            return Column(
              children: [
                Text('Ürün id: ${data.id}'),
                Text(data.name ?? 'İsim Verisi Yok'),
                Text(data.price ?? 'Fiyat Verisi Yok'),
                ElevatedButton(
                    onPressed: () {
                      // PlaceHolder.lastSelectedProductId = data.id;
                      // ref.refresh(getProductProvider(id: productId!));
                    },
                    child: const Text('Kaydet')),
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
