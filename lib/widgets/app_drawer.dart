import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopcart/providers/auth_provider.dart';
import 'package:shopcart/screens/orders_screen.dart';
import 'package:shopcart/screens/product_overview_screen.dart';
import 'package:shopcart/screens/user_products_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text("Hello User!"),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text("Shop"),
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, ProductOverviewScreen.routeId);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text("Orders"),
            onTap: () {
              Navigator.pushReplacementNamed(context, OrdersScreen.routeId);
              /*Navigator.pushReplacement(
                  context,
                  CustomRoute(
                    builder: (ctx) => OrdersScreen(),
                  ));*/
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text("Manage Products"),
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, UserProductsScreen.routeId);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Logout"),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/');
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
