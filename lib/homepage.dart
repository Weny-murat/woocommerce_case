import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woocommerce_case/add_product.dart';
import 'package:woocommerce_case/placeholder_data.dart';
import 'package:woocommerce_case/product_list.dart';
import 'package:woocommerce_case/providers/pageview_provider.dart';
import 'package:woocommerce_case/update_product.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageIndex = ref.watch(pageviewProvider);
    PageController pageController = PlaceHolder.pageController;
    return Scaffold(
      appBar: AppBar(
        title: const Text('WooCommerce Case Demo'),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: pageIndex,
        showElevation: true, // use this to remove appBar's elevation
        onItemSelected: (index) => ({
          ref.read(pageviewProvider.notifier).state = index,
          pageController.animateToPage(index,
              duration: const Duration(milliseconds: 300), curve: Curves.ease)
        }),
        items: [
          BottomNavyBarItem(
            icon: const Icon(Icons.manage_search_outlined),
            title: const Text('Ürün İncele'),
            activeColor: Colors.blue,
            inactiveColor: Colors.grey,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.add_box_outlined),
            title: const Text('Ürün Ekle'),
            activeColor: Colors.blue,
            inactiveColor: Colors.grey,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.list_alt_outlined),
            title: const Text('Ürünler'),
            activeColor: Colors.blue,
            inactiveColor: Colors.grey,
          ),
        ],
      ),
      body: SizedBox.expand(
          child: PageView(
        controller: pageController,
        onPageChanged: (index) {
          ref.read(pageviewProvider.notifier).state = index;
        },
        children: const [
          UpdateProduct(),
          AddProduct(),
          ProductList(),
        ],
      )),
    );
  }
}
