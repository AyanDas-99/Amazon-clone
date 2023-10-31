import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/stars.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/product_detail/services/product_details_services.dart';
import 'package:amazon_clone/features/search/screens/search_screen.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const String routeName = '/product-details';
  final Product product;
  const ProductDetailsScreen(this.product, {super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final productDetailServices = ProductDetailsServices();
  double avgRating = 0;
  double myRating = 0;

  @override
  void initState() {
    double totalRating = 0;
    super.initState();
    for (int i = 0; i < widget.product.rating!.length; i++) {
      totalRating += widget.product.rating![i].rating;
      if (widget.product.rating![i].userId ==
          context.read<UserProvider>().user.id) {
        myRating = widget.product.rating![i].rating;
      }
    }
    if (widget.product.rating!.isNotEmpty) {
      avgRating = totalRating / widget.product.rating!.length;
    }
    setState(() {});
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void addToCart() {
    productDetailServices.addToCart(context: context, product: widget.product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 42,
                    margin: const EdgeInsets.only(left: 15),
                    child: Material(
                      borderRadius: BorderRadius.circular(7),
                      elevation: 1,
                      child: TextFormField(
                        onFieldSubmitted: navigateToSearchScreen,
                        decoration: InputDecoration(
                          prefixIcon: InkWell(
                            onTap: () {},
                            child: const Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.only(top: 10),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                              borderSide: BorderSide.none),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            borderSide:
                                BorderSide(color: Colors.black38, width: 1),
                          ),
                          hintText: "Search Amazon.in",
                          hintStyle: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 42,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Icon(
                    Icons.mic,
                    color: Colors.black,
                    size: 25,
                  ),
                )
              ],
            ),
          )),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.product.id ?? widget.product.name),
                Stars(rating: avgRating),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 70, left: 5),
            child: Text(
              widget.product.name,
              softWrap: true,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          CarouselSlider(
            items: widget.product.images
                .map((i) => Builder(
                      builder: (context) => Image.network(
                        i,
                        fit: BoxFit.cover,
                        height: 200,
                      ),
                    ))
                .toList(),
            options: CarouselOptions(
              viewportFraction: 1,
              height: 250,
            ),
          ),
          const Divider(
            color: Colors.black12,
            thickness: 5,
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Deal Price: ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  TextSpan(
                      text: '\$${widget.product.price}',
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.red,
                          fontWeight: FontWeight.w600))
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: Text(widget.product.description),
          ),
          const Divider(
            color: Colors.black12,
            thickness: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: CustomButton(text: "Buy Now", onTap: () {}),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: CustomButton(
              text: "Add to cart",
              onTap: () => addToCart(),
              color: Colors.yellow.shade600,
            ),
          ),
          const Divider(
            color: Colors.black12,
            thickness: 5,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.topLeft,
            child: const Text(
              "Rate this product",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: RatingBar.builder(
                initialRating: myRating,
                allowHalfRating: true,
                itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: GlobalVariables.secondaryColor,
                    ),
                onRatingUpdate: (rating) {
                  productDetailServices.rateProduct(
                      context: context,
                      product: widget.product,
                      rating: rating);
                }),
          )
        ],
      )),
    );
  }
}
