import 'package:amazon_clone/common/widgets/stars.dart';
import 'package:amazon_clone/features/product_detail/screens/product_details_screen.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchedProduct extends StatelessWidget {
  final Product product;
  const SearchedProduct(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    double totalRating = 0;
    double avgRating = 0;
    for (int i = 0; i < product.rating!.length; i++) {
      totalRating += product.rating![i].rating;
      if (product.rating![i].userId == context.read<UserProvider>().user.id) {}
    }
    if (product.rating!.isNotEmpty) {
      avgRating = totalRating / product.rating!.length;
    }

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
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 5,
                ),
                child: Stars(rating: avgRating),
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
