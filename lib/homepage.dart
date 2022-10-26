import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woocommerce_case/screens/add_product.dart';
import 'package:woocommerce_case/models/placeholder_data.dart';
import 'package:woocommerce_case/screens/product_list.dart';
import 'package:woocommerce_case/providers/pageview_provider.dart';
import 'package:woocommerce_case/screens/update_product.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  DateTime timeBackPressed = DateTime.now();
  PageController pageController = PlaceHolder.pageController;
  @override
  Widget build(BuildContext context) {
    final pageIndex = ref.watch(pageviewProvider);
    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(timeBackPressed).inSeconds;
        bool exit = false;
        if (difference > 2) {
          timeBackPressed = DateTime.now();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Press back again to exit'),
            ),
          );
        } else {
          exit = true;
        }
        return exit;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('WooCommerce Case Demo'),
        ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: pageIndex,
          showElevation: true,
          onItemSelected: (index) => ({
            ref.read(pageviewProvider.notifier).state = index,
            pageController.animateToPage(index,
                duration: const Duration(milliseconds: 300), curve: Curves.ease)
          }),
          items: [
            BottomNavyBarItem(
              icon: const Icon(Icons.manage_search_outlined),
              title: const Text('Ürün İncele'),
              activeColor: Colors.blueGrey,
              inactiveColor: Colors.grey[800],
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.add_box_outlined),
              title: const Text('Ürün Ekle'),
              activeColor: Colors.blueGrey,
              inactiveColor: Colors.grey[800],
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.list_alt_outlined),
              title: const Text('Ürünler'),
              activeColor: Colors.blueGrey,
              inactiveColor: Colors.grey[800],
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
      ),
    );
  }
}
