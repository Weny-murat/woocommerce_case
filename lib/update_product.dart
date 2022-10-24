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
    TextEditingController priceController = TextEditingController();
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
        const Divider(),
        productAsync.when(
          data: (data) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Ürün adı: ${data.name}',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios_outlined,
                          color: Colors.green),
                      SizedBox(
                        width: 100,
                        child: TextFormField(
                          controller: textController,
                          decoration: const InputDecoration(
                            hintText: 'Yeni Ürün Adı',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.black,
                  ),
                  Text('Ürün id: ${data.id}'),
                  const Divider(
                    color: Colors.black,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Ürün fiyatı: ${data.price}'),
                      const Icon(Icons.arrow_forward_ios_outlined,
                          color: Colors.green),
                      SizedBox(
                        width: 100,
                        child: TextFormField(
                          controller: priceController,
                          decoration: const InputDecoration(
                            hintText: 'Yeni Ürün ID',
                          ),
                        ),
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
                            Image.asset(
                              'assets/appicon/icon.png',
                              color: Colors.blueGrey,
                            ),
                            Positioned(
                                bottom: 20,
                                right: -20,
                                child: RawMaterialButton(
                                  onPressed: () {},
                                  elevation: 2.0,
                                  fillColor: const Color(0xFFF5F6F9),
                                  padding: const EdgeInsets.all(5.0),
                                  shape: const CircleBorder(),
                                  child: const Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.blue,
                                  ),
                                )),
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
                          backgroundColor: Colors.green,
                        ),
                        onPressed: data.id == 0
                            ? null
                            : () async {
                                debugPrint(priceController.text);
                                await WooComApi.wc.put('products/${data.id}', {
                                  "regular_price": priceController.text
                                }).whenComplete(
                                    () => ref.refresh(productProvider));
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
                                await WooComApi.wc.delete(
                                    'products/${data.id}', {
                                  'force': true
                                }).whenComplete(() => ref
                                    .read(productIdProvider.notifier)
                                    .state = 0);
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
    );
  }
}
