import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monahawk_woocommerce/models/products.dart';
import 'package:woocommerce_case/placeholder_data.dart';
import 'package:woocommerce_case/providers/get_product_provider.dart';

class UpdateProduct extends ConsumerStatefulWidget {
  const UpdateProduct({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UpdateProductState();
}

class _UpdateProductState extends ConsumerState<UpdateProduct> {
  int? productId;
  WooProduct? product;
  @override
  void initState() {
    productId = PlaceHolder.lastSelectedProductId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productAsync = ref.watch(getProductProvider(id: productId));
    TextEditingController? textController;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextFormField(
            controller: textController,
            decoration: const InputDecoration(
              hintText: 'Ürün ID',
            ),
            onChanged: (value) {
              productId = int.parse(value);
            },
          ),
        ),
        ElevatedButton(onPressed: () {}, child: const Text('Ürün Ara')),
        productId == null
            ? const SizedBox()
            : productAsync.when(
                data: (data) {
                  product = data;
                  return Column(
                    children: [
                      Text('Ürün id: ${data.id}'),
                      Text(data.name ?? 'İsim Verisi Yok'),
                      Text(data.price ?? 'Fiyat Verisi Yok'),
                      RichText(
                        text: TextSpan(
                          text: 'Kategori: ',
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                                text: data.categories[0].name ??
                                    'Kategori Verisi Yok'),
                          ],
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            PlaceHolder.lastSelectedProductId = data.id;
                            ref.refresh(getProductProvider(id: productId!));
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
