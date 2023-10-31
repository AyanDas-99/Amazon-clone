import 'package:amazon_clone/features/product_detail/screens/product_details_screen.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartProduct extends StatefulWidget {
  final int index;
  CartProduct({super.key, required this.index});

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  @override
  Widget build(BuildContext context) {
    final productMap =
        context.watch<UserProvider>().user.cart[widget.index]['product'];
    final product = Product.fromMap(productMap);

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, ProductDetailsScreen.routeName,
          arguments: product),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(children: [
          Image.network(
            product.images[0],
            fit: BoxFit.fitWidth,
            height: 135,
            width: 135,
          ),
          Column(
            children: [
              Container(
                width: 235,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  product.name,
                  style: const TextStyle(fontSize: 16),
                  maxLines: 2,
                ),
              ),
              Container(
                width: 235,
                padding: const EdgeInsets.only(left: 10, top: 5),
                child: const Text(
                  'Eligible for free shiping',
                  maxLines: 2,
                ),
              ),
              Container(
                width: 235,
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 5,
                ),
                child: Text(
                  '\$${product.price}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                ),
              ),
              Container(
                width: 235,
                padding: const EdgeInsets.only(left: 10, top: 5),
                child: const Text(
                  'In Stock',
                  style: TextStyle(
                    color: Colors.teal,
                  ),
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
