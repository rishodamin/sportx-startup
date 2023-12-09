import 'package:flutter/material.dart';
import 'package:sportx/common/widgets/bottom_bar.dart';
import 'package:sportx/features/address/screens/address_screen.dart';
import 'package:sportx/features/admin/screens/add_product_screen.dart';
import 'package:sportx/features/auth/screens/auth_screen.dart';
import 'package:sportx/features/home/screens/category_deals_screens.dart';
import 'package:sportx/features/home/screens/home_screen.dart';
import 'package:sportx/features/order_details/screens/order_details.dart';
import 'package:sportx/features/product_details/screens/product_details_screen.dart';
import 'package:sportx/features/search/screens/search_screen.dart';
import 'package:sportx/models/product_models/product.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const AuthScreen(),
        settings: routeSettings,
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const HomeScreen(),
        settings: routeSettings,
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        builder: (_) => const BottomBar(),
        settings: routeSettings,
      );
    case AddProductScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const AddProductScreen(),
        settings: routeSettings,
      );
    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (_) => SearchScreen(
          searchQuery: searchQuery,
        ),
        settings: routeSettings,
      );
    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (_) => CategoryDealsScreen(
          category: category,
        ),
        settings: routeSettings,
      );
    case ProductDetailScreen.routeName:
      var args = routeSettings.arguments as Map<String, dynamic>;
      var product = args['product'];
      var searchQuery = args['searchQuery'];
      return MaterialPageRoute(
        builder: (_) => ProductDetailScreen(
          product: product,
          searchQuery: searchQuery,
        ),
        settings: routeSettings,
      );
    case AddressScreen.routeName:
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (_) => AddressScreen(
          amount: totalAmount,
        ),
        settings: routeSettings,
      );
    case OrderDetailScreen.routeName:
      var args = routeSettings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
        builder: (_) => OrderDetailScreen(
          product: args['product'],
          address: args['address'],
          userId: args['userId'],
          orderedAt: args['orderedAt'],
          status: args['status'],
          orderId: args['orderId'],
          totalAmount: args['totalAmount'],
        ),
        settings: routeSettings,
      );
    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen doesn\'t  exist!'),
          ),
        ),
      );
  }
}
