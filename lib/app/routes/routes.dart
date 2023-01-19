
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/ui/screens/sign_up/sign_up_screen.dart';
import 'package:flutter_bloc_template/ui/screens/user_profile/reviews/reviews_list.dart';

import '../../features/brands/model.dart';
import '../../features/catalog/categories/model/model.dart';
import '../../features/catalog/products/model/product.dart';
import '../../ui/screens/about_shop/about_shop.dart';
import '../../ui/screens/brand/brand_page.dart';
import '../../ui/screens/catalog/catalog_page.dart';
import '../../ui/screens/catalog/item_page/item_page.dart';
import '../../ui/screens/checkout/checkout_complete_page/checkout_complete_page.dart';
import '../../ui/screens/checkout/checkout_screen.dart';
import '../../ui/screens/checkout/payment_redirect_page/payment_redirect_page.dart';
import '../../ui/screens/loyalty_program/loyalty_program_screen.dart';
import '../../ui/screens/main_screen.dart';
import '../../ui/screens/promotion/promotion_screen.dart';
import '../../ui/screens/splash_screen.dart';
import '../../ui/screens/user_profile/adresses_list/adresses.dart';
import '../../ui/screens/user_profile/certificates/certificates_screen.dart';
import '../../ui/screens/user_profile/my_orders/order_details_page.dart';
import '../../ui/screens/user_profile/my_orders/orders_list.dart';
import '../../ui/screens/user_profile/personal_data_screen/personal_data_page.dart';
import '../../ui/screens/user_profile/promo_actions/promo_actions_screen.dart';
import '../../ui/screens/user_profile/recievers_list/recievers.dart';
import '../../ui/screens/write_review/write_review_complete.dart';
import '../../ui/screens/write_review/write_review_screen.dart';

class Routes {
  static const splash = 'splash';
  static const home = '/';
  static const signUp = '/signUp';
  static const catalog = '/catalog';
  static const loyaltyProgramScreen = '/loyaltyProgramScreen';
  static const aboutShopScreen = '/aboutShopScreen';
  static const promotionsListPage = '/promotionsListPage';
  static const recieversList = '/recieversList';
  static const adressesList = '/adressesList';
  static const checkOut = '/checkOut';
  static const paymentRedirect = '/paymentRedirect';
  static const checkoutCompletePage = '/checkoutCompletePage';
  static const ordersList = '/ordersList';
  static const reviewList = '/reviewList';
  static const writeReview = '/writeReview';
  static const writeReviewCompleteScreen = '/writeReviewCompleteScreen';
  static const certificatesScreen = '/certificatesScreen';
  static const productScreen = '/productScreen';
  static const orderDetailsScreen = '/orderDetailsScreen';
  static const brand = '/brand';
  static const promotionScreen = '/promotionScreen';
  static const personalData = "/personalData";

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
      case signUp:
        return CupertinoPageRoute(builder: (context) => const SignUpScreen());
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
      case promotionsListPage:
        return CupertinoPageRoute(builder: (context) => const PromotionsListPage());
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
      case reviewList:
        return CupertinoPageRoute(builder: (context) => const ReviewsList());
      case writeReviewCompleteScreen:
        return CupertinoPageRoute(builder: (context) => const WriteReviewCompleteScreen());
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
      case personalData:
        return CupertinoPageRoute(builder: ((context) => const PersonalDataPage()));
      default:
        return CupertinoPageRoute(builder: (context) => const Scaffold());
    }
  }
}
