import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopcart/providers/order_provider.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem orderItem;

  const OrderItem(this.orderItem);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
      height: _expanded
          ? min(widget.orderItem.products.length * 20.0 + 120, 220)
          : 96.0,
      child: Card(
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text("₹${widget.orderItem.amount}"),
              subtitle: Text(DateFormat('dd-MM-yyyy hh:mm')
                  .format(widget.orderItem.dateTime)),
              trailing: IconButton(
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
                icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeIn,
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 4.0),
              height: _expanded
                  ? min(widget.orderItem.products.length * 20.0 + 20, 100)
                  : 0.0,
              child: ListView(
                children: widget.orderItem.products
                    .map((prod) => Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  prod.title,
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${prod.quantity} x ₹${prod.price}",
                                  style: TextStyle(
                                      fontSize: 18.0, color: Colors.grey),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 4.0,
                            )
                          ],
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
