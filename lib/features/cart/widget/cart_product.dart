import 'package:amazon_clone/features/cart/services/cart_services.dart';
import 'package:amazon_clone/features/product_detail/screens/product_details_screen.dart';
import 'package:amazon_clone/features/product_detail/services/product_details_services.dart';
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
    final productMap = context.watch<UserProvider>().user.cart[widget.index];
    final product = Product.fromMap(productMap['product']);
    final quantity = productMap['quantity'];

    final ProductDetailsServices productDetailsServices =
        ProductDetailsServices();

    final CartServices cartServices = CartServices();

    void increaseQuantity(Product product) {
      productDetailsServices.addToCart(context: context, product: product);
    }

    void decreaseQuantity(Product product) {
      cartServices.removeFromCart(context: context, product: product);
    }

    return Column(
      children: [
        GestureDetector(
          onTap: () => Navigator.pushNamed(
              context, ProductDetailsScreen.routeName,
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
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black12,
                ),
                // padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    Container(
                      child: IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () => decreaseQuantity(product),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.white,
                      child: Text(quantity.toString()),
                    ),
                    Container(
                      child: IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => increaseQuantity(product),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
