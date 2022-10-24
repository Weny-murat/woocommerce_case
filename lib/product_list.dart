import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woocommerce_case/placeholder_data.dart';
import 'package:woocommerce_case/providers/get_product_provider.dart';
import 'package:woocommerce_case/providers/product_list_provider.dart';
import 'package:woocommerce_case/providers/pageview_provider.dart';

class ProductList extends ConsumerWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productListProvider);
    return productsAsync.when(
      data: (data) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              height: MediaQuery.of(context).size.height / 20,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      elevation: 0,
                    ),
                    onPressed: () async {
                      ref.read(productListPageProvider.notifier).state--;
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.arrow_back_ios),
                        Text('Önceki'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'Sayfa: ${ref.watch(productListPageProvider)}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      elevation: 0,
                    ),
                    onPressed: () async {
                      ref.read(productListPageProvider.notifier).state++;
                    },
                    child: Row(
                      children: const [
                        Text('Sonraki'),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  debugPrint(data.length.toString());
                  return data.isEmpty
                      ? const Center(
                          child: Text(
                          'Ürün Yok',
                          style: TextStyle(color: Colors.black),
                        ))
                      : Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width - 10,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                border: Border.all(color: Colors.black),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.width / 2,
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Image.network(
                                        data[index].images[0].src!,
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text('Ürün id: ${data[index].id}'),
                                      Text(data[index].name ??
                                          'İsim Verisi Yok'),
                                      Text(data[index].price ??
                                          'Fiyat Verisi Yok'),
                                      RichText(
                                        text: TextSpan(
                                          text: 'Kategori: ',
                                          style: DefaultTextStyle.of(context)
                                              .style,
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: data[index]
                                                        .categories[0]
                                                        .name ??
                                                    'Kategori Verisi Yok'),
                                          ],
                                        ),
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            PlaceHolder.pageController
                                                .animateToPage(0,
                                                    duration: const Duration(
                                                        milliseconds: 500),
                                                    curve: Curves.ease);
                                            ref
                                                .read(
                                                    productIdProvider.notifier)
                                                .state = data[index].id!;
                                            ref
                                                .read(pageviewProvider.notifier)
                                                .state = 2;
                                          },
                                          child: const Text('İncele'))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        );
                }),
          ),
        ],
      ),
      error: (error, stackTrace) => const Center(
          child: Text(
        'Hatalı',
        style: TextStyle(color: Colors.black),
      )),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
