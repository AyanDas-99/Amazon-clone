import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/features/accounts/widgets/single_product.dart';
import 'package:amazon_clone/features/admin/screens/add_product_screen.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final adminServices = AdminServices();
  List<Product>? products;

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    products = await adminServices.fetchAllProducts(context);
    print(products);
    setState(() {});
  }

  void deleteProduct(Product product, int index) async {
    adminServices.deleteProduct(
        context: context,
        product: product,
        onSuccess: () {
          products!.removeAt(index);

          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader()
        : Scaffold(
            body: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                final product = products![index];
                return Column(
                  children: [
                    SizedBox(
                      height: 140,
                      child: SingleProduct(image: product.images[0]),
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          product.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        )),
                        IconButton(
                            onPressed: () => deleteProduct(product, index),
                            icon: const Icon(Icons.delete_outline)),
                      ],
                    )
                  ],
                );
              },
              itemCount: products!.length,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, AddProductScreen.routeName);
              },
              child: Icon(Icons.add),
              tooltip: "Add a product",
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
