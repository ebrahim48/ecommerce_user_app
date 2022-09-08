import 'package:ecommerce_user_project/pages/cart_page.dart';
import 'package:ecommerce_user_project/pages/checkout_page.dart';
import 'package:ecommerce_user_project/pages/launcher_page.dart';
import 'package:ecommerce_user_project/pages/login_page.dart';
import 'package:ecommerce_user_project/pages/order_successfull_page.dart';
import 'package:ecommerce_user_project/pages/otp_page.dart';
import 'package:ecommerce_user_project/pages/phone_verification.dart';
import 'package:ecommerce_user_project/pages/product_details_page.dart';
import 'package:ecommerce_user_project/pages/products_page.dart';
import 'package:ecommerce_user_project/pages/regestration_page.dart';
import 'package:ecommerce_user_project/pages/user_address_page.dart';
import 'package:ecommerce_user_project/pages/user_profile.dart';
import 'package:ecommerce_user_project/providers/cart_provider.dart';
import 'package:ecommerce_user_project/providers/order_provider.dart';
import 'package:ecommerce_user_project/providers/product_provider.dart';
import 'package:ecommerce_user_project/providers/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => ProductProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => OrderProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Map<int, Color> pokeballRedSwatch = {
      50: const Color.fromARGB(255, 230, 66, 25),
      100: const Color.fromARGB(255, 230, 66, 25),
      200: const Color.fromARGB(255, 230, 66, 25),
      300: const Color.fromARGB(255, 230, 66, 25),
      400: const Color.fromARGB(255, 230, 66, 25),
      500: const Color.fromARGB(255, 230, 66, 25),
      600: const Color.fromARGB(255, 230, 66, 25),
      700: const Color.fromARGB(255, 230, 66, 25),
      800: const Color.fromARGB(255, 230, 66, 25),
      900: const Color.fromARGB(255, 230, 66, 25),
    };
    MaterialColor appColor = MaterialColor(0xffe64219, pokeballRedSwatch);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: appColor,
      ),
      initialRoute: LauncherPage.routeName,
      routes: {
        LauncherPage.routeName: (context) => const LauncherPage(),
        LoginPage.routeName: (context) => const LoginPage(),
        ProductPage.routeName: (context) => const ProductPage(),
        ProductDetailsPage.routeName: (context) => ProductDetailsPage(),
        PhoneVerification.routeName: (context) =>   PhoneVerification(),
        OtpPage.routeName: (context) => const  OtpPage(),
        RegistrationPage.routeName: (context) => const  RegistrationPage(),
        UserProfilePage.routeName: (context) => const  UserProfilePage(),
        CartPage.routeName: (context) => const  CartPage(),
        CheckoutPage.routeName: (context) => const  CheckoutPage(),
        UserAddressPage.routeName: (context) =>   const UserAddressPage(),
        OrderSuccessfulPage.routeName: (context) =>   const OrderSuccessfulPage(),
      },
    );
  }
}
