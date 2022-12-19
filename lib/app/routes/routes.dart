import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc_template/features/order/model.dart';
import 'package:flutter_bloc_template/ui/screens/about_shop/about_shop.dart';
import 'package:flutter_bloc_template/ui/screens/catalog/item_page/item_page.dart';
import 'package:flutter_bloc_template/ui/screens/checkout/checkout_complete_page/checkout_complete_page.dart';
import 'package:flutter_bloc_template/ui/screens/loyalty_program/loyalty_program_screen.dart';
import 'package:flutter_bloc_template/ui/screens/checkout/payment_redirect_page/payment_redirect_page.dart';
import 'package:flutter_bloc_template/ui/screens/user_profile/adresses_list/adresses.dart';
import 'package:flutter_bloc_template/ui/screens/user_profile/my_orders/order_details_page.dart';

import '../../features/catalog/products/model/product.dart';
import '../../ui/screens/checkout/checkout_screen.dart';
import '../../ui/screens/main_screen.dart';
import '../../ui/screens/login_screen/login_screen.dart';
import '../../ui/screens/user_profile/my_orders/orders_list.dart';
import '../../ui/screens/user_profile/recievers_list/recievers.dart';

class Routes {
  static get home => CupertinoPageRoute(builder: (context) => const MainScreen());
  static get signIn => CupertinoPageRoute(builder: (context) => const LoginPage());
  static get loyaltyProgramScreen => CupertinoPageRoute(builder: (context) => const LoyaltyProgramScreen());
  static get aboutShopScreen => CupertinoPageRoute(builder: (context) => const AboutShopScreen());
  static get recieversList => CupertinoPageRoute(builder: ((context) => const RecieversListScreen()));
  static get adressesList => CupertinoPageRoute(builder: ((context) => const AdressesListScreen()));
  static get checkOut => CupertinoPageRoute(builder: ((context) => CheckoutScreen(key: UniqueKey())));
  static get paymentRedirect => CupertinoPageRoute(builder: ((context) => const PaymentRedirectPage()));
  static get checkoutCompletePage => CupertinoPageRoute(builder: ((context) => const CheckoutCompletePage()));
  static get ordersList => CupertinoPageRoute(builder: ((context) => const OrdersListPage()));
  static Route productScreen(Product product) => CupertinoPageRoute(
      builder: ((context) => ProductScreen(
            product: product,
          )));
  static Route orderDetailsScreen(Order order) => CupertinoPageRoute(
      builder: ((context) => OrderDetailsPage(
            order: order,
          )));
}
