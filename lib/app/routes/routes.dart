import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/features/catalog/categories/model/model.dart';
import 'package:flutter_bloc_template/ui/screens/about_shop/about_shop.dart';
import 'package:flutter_bloc_template/ui/screens/brand/brand_page.dart';
import 'package:flutter_bloc_template/ui/screens/catalog/catalog_page.dart';
import 'package:flutter_bloc_template/ui/screens/catalog/item_page/item_page.dart';
import 'package:flutter_bloc_template/ui/screens/checkout/checkout_complete_page/checkout_complete_page.dart';
import 'package:flutter_bloc_template/ui/screens/loyalty_program/loyalty_program_screen.dart';
import 'package:flutter_bloc_template/ui/screens/checkout/payment_redirect_page/payment_redirect_page.dart';
import 'package:flutter_bloc_template/ui/screens/promotion/promotion_screen.dart';
import 'package:flutter_bloc_template/ui/screens/splash_screen.dart';
import 'package:flutter_bloc_template/ui/screens/user_profile/adresses_list/adresses.dart';
import 'package:flutter_bloc_template/ui/screens/user_profile/my_orders/order_details_page.dart';
import 'package:flutter_bloc_template/ui/screens/write_review/write_review_screen.dart';

import '../../features/brands/model.dart';
import '../../features/catalog/products/model/product.dart';
import '../../ui/screens/checkout/checkout_screen.dart';
import '../../ui/screens/main_screen.dart';
import '../../ui/screens/login_screen/login_screen.dart';
import '../../ui/screens/user_profile/certificates/certificates_screen.dart';
import '../../ui/screens/user_profile/my_orders/orders_list.dart';
import '../../ui/screens/user_profile/promo_actions/promo_actions_screen.dart';
import '../../ui/screens/user_profile/recievers_list/recievers.dart';

class Routes {
  static const splash = 'splash';
  static const home = '/';
  static const login = 'login';
  static const catalog = '/catalog';
  static const loyaltyProgramScreen = '/loyaltyProgramScreen';
  static const aboutShopScreen = '/aboutShopScreen';
  static const promoActionScreen = '/promoActionScreen';
  static const recieversList = '/recieversList';
  static const adressesList = '/adressesList';
  static const checkOut = '/checkOut';
  static const paymentRedirect = '/paymentRedirect';
  static const checkoutCompletePage = '/checkoutCompletePage';
  static const ordersList = '/ordersList';
  static const writeReview = '/writeReview';
  static const certificatesScreen = '/certificatesScreen';
  static const productScreen = '/productScreen';
  static const orderDetailsScreen = '/orderDetailsScreen';
  static const brand = '/brand';
  static const promotionScreen = '/promotionScreen';

  static String currentRoute = splash;

  static Route<dynamic> onGenerateRouted(RouteSettings routeSettings) {
    //to track current route
    //this will only track pushed route on top of previous route
    currentRoute = routeSettings.name ?? "";
    switch (routeSettings.name) {
      case splash:
        return CupertinoPageRoute(builder: (context) => const SplashScreen());
      case home:
        return CupertinoPageRoute(builder: (context) => const MainScreen());
      case login:
        return CupertinoPageRoute(builder: (context) => const LoginPage());
      case catalog:
        Category? category;
        if (routeSettings.name != null && routeSettings.arguments != null) {
          category =
              Category.fromJson((routeSettings.arguments! as Map)["id"], (routeSettings.arguments! as Map));
        }
        return CatalogPage.route(category);
      case loyaltyProgramScreen:
        return CupertinoPageRoute(builder: (context) => const LoyaltyProgramScreen());
      case aboutShopScreen:
        return CupertinoPageRoute(builder: (context) => const AboutShopScreen());
      case promoActionScreen:
        return CupertinoPageRoute(builder: (context) => const PromoActionScreen());
      case recieversList:
        return CupertinoPageRoute(builder: (context) => const RecieversListScreen());
      case adressesList:
        return CupertinoPageRoute(builder: (context) => const AdressesListScreen());
      case checkOut:
        return CupertinoPageRoute(builder: (context) => const CheckoutScreen());
      case paymentRedirect:
        return CupertinoPageRoute(builder: (context) => const PaymentRedirectPage());
      case checkoutCompletePage:
        return CupertinoPageRoute(builder: (context) => const CheckoutCompletePage());
      case ordersList:
        return CupertinoPageRoute(builder: (context) => const OrdersListPage());
      case certificatesScreen:
        return CupertinoPageRoute(builder: (context) => const CertificatesScreen());
      case writeReview:
        return WriteReviewScreen.route(routeSettings);
      case promotionScreen:
        return PromotionScreen.route(routeSettings);
      case productScreen:
        Product product = routeSettings.arguments is Product
            ? routeSettings.arguments as Product
            : Product.fromJson((routeSettings.arguments! as Map)["id"], routeSettings.arguments! as Map);
        return ProductScreen.route(product);
      case orderDetailsScreen:
        return OrderDetailsPage.route(routeSettings);
      case brand:
        var brand = routeSettings.arguments as Brand;
        return BrandPage.route(brand);
      default:
        return CupertinoPageRoute(builder: (context) => const Scaffold());
    }
  }
}
