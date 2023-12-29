import 'package:flutter/widgets.dart';
import 'package:gp_fe/timeelinee/screens/forms/formscom.dart';
import 'package:gp_fe/timeelinee/screens/products/products_screen.dart';
import 'screens/cart/cart_screen.dart';
import 'screens/details/details_screen.dart';
import 'screens/home/home_screen.dart';

final Map<String, WidgetBuilder> routes = {
  HomeScreencom.routeName: (context) => const HomeScreencom(),
  ProductsScreen.routeName: (context) => const ProductsScreen(),
  DetailsScreen.routeName: (context) => const DetailsScreen(),
  CartScreen.routeName: (context) => const CartScreen(),
  MyButtonsScreen.routeName: (context) => MyButtonsScreen(),
};
