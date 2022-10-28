import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woocommerce_case/infrastructure/async_value_extension.dart';
import 'package:woocommerce_case/dummyData/placeholder_data.dart';
import 'package:woocommerce_case/providers/product_list_provider.dart';
import 'package:woocommerce_case/screens/product_controller.dart';

class AddProduct extends ConsumerStatefulWidget {
  const AddProduct({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddProductState();
}

class _AddProductState extends ConsumerState<AddProduct> {
  @override
  Widget build(BuildContext context) {
    final AsyncValue<void> state = ref.watch(productControllerProvider);
    ref.listen<AsyncValue>(productControllerProvider,
        (_, state) => state.showSnackbarOnChange(context));
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
          onPressed: state.isLoading
              ? null
              : () {
                  ref
                      .read(productControllerProvider.notifier)
                      .postProduct(PlaceHolder.data)
                      .whenComplete(() => ref.refresh(productListProvider));
                },
          child: state.isLoading
              ? const CircularProgressIndicator()
              : const Text('Deneme Ürünü Ekle'),
        ),
      ],
    );
  }
}
