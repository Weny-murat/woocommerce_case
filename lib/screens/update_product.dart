import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woocommerce_case/infrastructure/extensions/async_value_extension.dart';
import 'package:woocommerce_case/providers/get_product_provider.dart';
import 'package:woocommerce_case/providers/product_list_provider.dart';
import 'package:woocommerce_case/screens/product_controller.dart';
import 'package:woocommerce_case/screens/custom_widgets/info_bar.dart';
import 'package:woocommerce_case/screens/custom_widgets/standart_edit_field.dart';

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
    TextEditingController nameController = TextEditingController();
    TextEditingController regularPriceController = TextEditingController();
    TextEditingController salePriceController = TextEditingController();
    final AsyncValue<void> state = ref.watch(productControllerProvider);
    ref.listen<AsyncValue>(productControllerProvider,
        (_, state) => state.showSnackbarOnChange(context));
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: textController,
              decoration: const InputDecoration(
                hintText: 'Ürün aramak için Id giriniz',
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
          const Divider(),
          productAsync.when(
            data: (data) {
              nameController.text = data.name!;
              regularPriceController.text = data.price!;
              salePriceController.text = data.salePrice!;
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InfoBar(
                      title: 'Geçerli Ürün Id: ',
                      value: data.id!.toString(),
                      isEditable: false,
                    ),
                    InfoBar(
                      title: 'Geçerli Ürün Fiyatı: ',
                      value: data.price!,
                      isEditable: false,
                    ),
                    InfoBar(
                      title: 'Geçerli Ürün Adı: ',
                      value: data.name!,
                      isEditable: true,
                      textFormField: StandartEditField(
                        formatter: FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z0-9-]')),
                        nameController: nameController,
                      ),
                    ),
                    InfoBar(
                      title: 'Fiyat: ',
                      value: data.regularPrice!,
                      isEditable: true,
                      textFormField: StandartEditField(
                        nameController: regularPriceController,
                        formatter: FilteringTextInputFormatter.allow(
                            RegExp(r'[0-9.]')),
                      ),
                    ),
                    InfoBar(
                      title: 'İndirimli Fiyat: ',
                      value: data.salePrice!,
                      isEditable: true,
                      textFormField: StandartEditField(
                        formatter: FilteringTextInputFormatter.allow(
                            RegExp(r'[0-9.]')),
                        nameController: salePriceController,
                      ),
                    ),
                    const Divider(
                      color: Colors.black,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 300,
                          height: MediaQuery.of(context).size.height / 3,
                          child: data.images.isNotEmpty
                              ? Image.network(data.images[0].src!)
                              : const Center(child: Text('Resim yok')),
                        ),
                        const Icon(Icons.arrow_forward_ios_outlined,
                            color: Colors.green),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 300,
                          height: MediaQuery.of(context).size.height / 3,
                          child: Stack(
                            clipBehavior: Clip.none,
                            fit: StackFit.expand,
                            children: [
                              const Center(
                                  child: Text('Henüz Resim seçilmedi')),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: FloatingActionButton(
                                    onPressed: () async {},
                                    child: const Icon(Icons.add),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey,
                          ),
                          onPressed: data.id == 0 || state.isLoading
                              ? null
                              : () => ref
                                  .read(productControllerProvider.notifier)
                                  .updateProduct(
                                      id: data.id!.toString(),
                                      data: {
                                        'name': nameController.text,
                                        'regular_price':
                                            regularPriceController.text,
                                        'sale_price': salePriceController.text,
                                      })
                                  .whenComplete(
                                      () => ref.refresh(productProvider))
                                  .whenComplete(
                                      () => ref.refresh(productListProvider)),
                          child: state.isLoading
                              ? const CircularProgressIndicator()
                              : const Text('Güncelle'),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          onPressed: data.id == 0 || state.isLoading
                              ? null
                              : () => ref
                                  .read(productControllerProvider.notifier)
                                  .deleteProduct(data.id!)
                                  .whenComplete(
                                      () => ref.refresh(productIdProvider))
                                  .whenComplete(
                                      () => ref.refresh(productListProvider)),
                          child: state.isLoading
                              ? const CircularProgressIndicator()
                              : const Text('Sil'),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
            error: (error, stackTrace) => const Text('Bir Sorun Var'),
            loading: () => const CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
