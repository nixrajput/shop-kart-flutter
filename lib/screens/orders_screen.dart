import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopcart/providers/order_provider.dart' show OrderProvider;
import 'package:shopcart/widgets/app_drawer.dart';
import 'package:shopcart/widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeId = 'orders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future:
            Provider.of<OrderProvider>(context, listen: false).fetchOrders(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CupertinoActivityIndicator());
          } else {
            if (dataSnapshot.error != null) {
              return Center(
                  child: Text(
                "An error occurred!",
                textAlign: TextAlign.center,
                style: TextStyle(color: Theme.of(context).errorColor),
              ));
            } else {
              return Consumer<OrderProvider>(
                builder: (ctx, orderData, child) => ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
