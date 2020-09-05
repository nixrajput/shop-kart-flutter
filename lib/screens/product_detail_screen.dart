import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopcart/providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeId = 'product-detail';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProducts = Provider.of<ProductsProvider>(context, listen: false)
        .findById(productId);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: deviceSize.height * 0.4,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(loadedProducts.title),
              background: Hero(
                tag: loadedProducts.id,
                child: Image.network(
                  loadedProducts.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: 10.0,
              ),
              Text(
                "₹${loadedProducts.price}",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 20.0),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                width: double.infinity,
                child: Text(
                  "${loadedProducts.desc}",
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
              SizedBox(
                height: 800.0,
              )
            ]),
          )
        ],
      ),
    );
  }
}
