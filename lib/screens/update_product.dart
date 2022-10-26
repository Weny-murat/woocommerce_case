import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woocommerce_case/providers/get_product_provider.dart';
import 'package:woocommerce_case/infrastructure/woocom_api.dart';
import 'package:woocommerce_case/providers/product_list_provider.dart';

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
    TextEditingController priceController = TextEditingController();

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
              priceController.text = data.price!;
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Geçerli Ürün id: ${data.id}'),
                    const Divider(
                      color: Colors.black,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Ürün adı: ${data.name}',
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Icon(Icons.arrow_forward_ios_outlined,
                                  color: Colors.green),
                            ),
                            SizedBox(
                              width: 100,
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                controller: nameController,
                                decoration: const InputDecoration(
                                  hintText: 'Yeni Ürün Adı',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.black,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Ürün fiyatı: ${data.price}'),
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Icon(Icons.arrow_forward_ios_outlined,
                                  color: Colors.green),
                            ),
                            SizedBox(
                              width: 100,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: priceController,
                                decoration: const InputDecoration(
                                  hintText: 'Yeni Fiyat',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
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
                          onPressed: data.id == 0
                              ? null
                              : () async {
                                  try {
                                    await WooComApi.wc
                                        .put('products/${data.id}', {
                                          "name": nameController.text,
                                          "price": priceController.text
                                        })
                                        .whenComplete(() => showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  title: const Text('Başarılı'),
                                                  content: const Text(
                                                      'Ürün güncellendi'),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        child:
                                                            const Text('Tamam'))
                                                  ],
                                                )))
                                        .whenComplete(
                                            () => ref.refresh(productProvider));
                                  } catch (e) {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: const Text('Hata'),
                                              content: Text(e.toString()),
                                              actions: [
                                                TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    child: const Text('Tamam'))
                                              ],
                                            ));
                                  }
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
                                  try {
                                    await WooComApi.wc.delete(
                                        'products/${data.id}',
                                        {'force': true}).whenComplete(() {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: const Text('Başarılı'),
                                                content:
                                                    const Text('Ürün silindi'),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                      child:
                                                          const Text('Tamam'))
                                                ],
                                              )).whenComplete(() {
                                        ref
                                            .read(productIdProvider.notifier)
                                            .state = 0;
                                        ref.refresh(productListProvider);
                                      });
                                    });
                                  } catch (e) {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: const Text('Hata'),
                                              content: Text(e.toString()),
                                              actions: [
                                                TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    child: const Text('Tamam'))
                                              ],
                                            ));
                                  }
                                },
                          child: const Text('Sil'),
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
