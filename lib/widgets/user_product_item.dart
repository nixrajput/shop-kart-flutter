import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopcart/providers/products_provider.dart';
import 'package:shopcart/screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  const UserProductItem({this.title, this.imageUrl, this.id});

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: FittedBox(
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.pushNamed(context, EditProductScreen.routeId,
                    arguments: id);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                try {
                  await Provider.of<ProductsProvider>(context, listen: false)
                      .deleteProduct(id)
                      .then((_) {
                    scaffold.showSnackBar(
                        SnackBar(content: Text("Product deleted.")));
                  });
                } catch (error) {
                  scaffold.showSnackBar(
                      SnackBar(content: Text("Deleting failed!")));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
