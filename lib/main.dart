import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopcart/helpers/custom_route.dart';
import 'package:shopcart/providers/auth_provider.dart';
import 'package:shopcart/providers/cart_provider.dart';
import 'package:shopcart/providers/order_provider.dart';
import 'package:shopcart/providers/products_provider.dart';
import 'package:shopcart/screens/auth_screen.dart';
import 'package:shopcart/screens/cart_screen.dart';
import 'package:shopcart/screens/edit_product_screen.dart';
import 'package:shopcart/screens/orders_screen.dart';
import 'package:shopcart/screens/product_detail_screen.dart';
import 'package:shopcart/screens/product_overview_screen.dart';
import 'package:shopcart/screens/splash_screen.dart';
import 'package:shopcart/screens/user_products_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Auth()),
        ChangeNotifierProxyProvider<Auth, ProductsProvider>(
//            create: (ctx) => ProductsProvider(),
            update: (ctx, auth, previousProducts) => ProductsProvider(
                  auth.token,
                  auth.userId,
                  previousProducts == null ? [] : previousProducts.items,
                )),
        ChangeNotifierProvider(create: (ctx) => CartProvider()),
        ChangeNotifierProxyProvider<Auth, OrderProvider>(
          update: (ctx, auth, previousOrders) => OrderProvider(
            auth.token,
            auth.userId,
            previousOrders == null ? [] : previousOrders.orders,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'ShopKart',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            pageTransitionsTheme: PageTransitionsTheme(builders: {
              TargetPlatform.android: CustomPageTransitionBuilder(),
              TargetPlatform.iOS: CustomPageTransitionBuilder(),
            }),
          ),
          home: auth.isAuth
              ? ProductOverviewScreen()
              : FutureBuilder(
                  future: auth.autoLogin(),
                  builder: (ctx, authResult) =>
                      authResult.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          routes: {
            ProductOverviewScreen.routeId: (ctx) => ProductOverviewScreen(),
            ProductDetailScreen.routeId: (ctx) => ProductDetailScreen(),
            CartScreen.routeId: (ctx) => CartScreen(),
            OrdersScreen.routeId: (ctx) => OrdersScreen(),
            UserProductsScreen.routeId: (ctx) => UserProductsScreen(),
            EditProductScreen.routeId: (ctx) => EditProductScreen(),
            AuthScreen.routeId: (ctx) => AuthScreen(),
          },
        ),
      ),
    );
  }
}
