import 'package:flutter/material.dart';

class PlaceHolder {
  static PageController pageController = PageController();
  static int? lastSelectedProductId;
  static const data = <String, dynamic>{
    'name': "Ürün Adı",
    'type': "simple",
    'regular_price': "21.99",
    'description': "Burası çooooooook uzun bir ürün tanıtım yazısıdır.",
    'short_description': "Kısacık bir ürün tanıtım.",
    'categories': [
      {'id': 9},
      {'id': 14}
    ],
    'images': [
      {
        'src':
            "http://demo.woothemes.com/woocommerce/wp-content/uploads/sites/56/2013/06/T_2_front.jpg"
      },
      {
        'src':
            "http://demo.woothemes.com/woocommerce/wp-content/uploads/sites/56/2013/06/T_2_back.jpg"
      }
    ]
  };
}
