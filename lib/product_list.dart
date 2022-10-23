import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woocommerce_case/add_product.dart';
import 'package:woocommerce_case/placeholder_data.dart';
import 'package:woocommerce_case/providers/get_products_provider.dart';
import 'package:woocommerce_case/providers/pageview_provider.dart';
import 'package:woocommerce_case/update_product.dart';

class ProductList extends ConsumerWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(getProductsProvider);
    return productsAsync.when(
      data: (data) => ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(color: Colors.black),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width / 2,
                          width: MediaQuery.of(context).size.width / 2,
                          child: Image.network(
                            data[index].images[0].src!,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Text('Ürün id: ${data[index].id}'),
                          Text(data[index].name ?? 'İsim Verisi Yok'),
                          Text(data[index].price ?? 'Fiyat Verisi Yok'),
                          RichText(
                            text: TextSpan(
                              text: 'Kategori: ',
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                    text: data[index].categories[0].name ??
                                        'Kategori Verisi Yok'),
                              ],
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                PlaceHolder.lastSelectedProductId =
                                    data[index].id;
                                PlaceHolder.pageController.animateToPage(2,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.ease);
                                ref.read(pageviewProvider.notifier).state = 2;
                              },
                              child: const Text('Güncelle'))
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
      error: (error, stackTrace) => const Center(child: Text('Hatalı')),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageIndex = ref.watch(pageviewProvider);
    PageController pageController = PlaceHolder.pageController;
    return Scaffold(
      appBar: AppBar(
        title: const Text('WooCommerce Case'),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: pageIndex,
        showElevation: true, // use this to remove appBar's elevation
        onItemSelected: (index) => ({
          ref.read(pageviewProvider.notifier).state = index,
          PlaceHolder.lastSelectedProductId = null,
          pageController.animateToPage(index,
              duration: const Duration(milliseconds: 300), curve: Curves.ease)
        }),
        items: [
          BottomNavyBarItem(
            icon: const Icon(Icons.list_alt_outlined),
            title: const Text('Ürünler'),
            activeColor: Colors.blue,
          ),
          BottomNavyBarItem(
              icon: const Icon(Icons.add_box_outlined),
              title: const Text('Ürün Ekle'),
              activeColor: Colors.blue),
          BottomNavyBarItem(
              icon: const Icon(Icons.update_outlined),
              title: const Text('Ürün Güncelle'),
              activeColor: Colors.blue),
          BottomNavyBarItem(
              icon: const Icon(Icons.delete_outline_outlined),
              title: const Text('Ürün Sil'),
              activeColor: Colors.blue),
          BottomNavyBarItem(
              icon: const Icon(Icons.list_outlined),
              title: const Text('Ürün Listele'),
              activeColor: Colors.blue),
        ],
      ),
      body: SizedBox.expand(
          child: PageView(
        controller: pageController,
        onPageChanged: (index) {
          ref.read(pageviewProvider.notifier).state = index;
        },
        children: const [
          ProductList(),
          AddProduct(),
          UpdateProduct(),
          Center(child: Text('Ürün Sil')),
          Center(child: Text('Ürün Listele')),
        ],
      )),
    );
  }
}
