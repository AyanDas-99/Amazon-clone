import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/accounts/screens/accounts_screen.dart';
import 'package:amazon_clone/features/cart/screens/cart_screen.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/bottomBar';
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth = 42;

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  List<Widget> pages = const [
    HomeScreen(),
    AccountsScreen(),
    CartScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final userCartLength = context.watch<UserProvider>().user.cart.length;

    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        onTap: updatePage,
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        items: [
          // Home
          BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: _page == 0
                              ? GlobalVariables.selectedNavBarColor
                              : GlobalVariables.backgroundColor)),
                ),
                child: const Icon(Icons.home_outlined),
              ),
              label: ''),
          // Accounts
          BottomNavigationBarItem(
              label: '',
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: _page == 1
                              ? GlobalVariables.selectedNavBarColor
                              : GlobalVariables.backgroundColor)),
                ),
                child: const Icon(Icons.person_outline_outlined),
              )),
          // Cart
          BottomNavigationBarItem(
              label: '',
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: _page == 2
                              ? GlobalVariables.selectedNavBarColor
                              : GlobalVariables.backgroundColor)),
                ),
                child: Badge(
                  offset: const Offset(10, -5),
                  backgroundColor: GlobalVariables.backgroundColor,
                  largeSize: 25,
                  textColor: Colors.black,
                  textStyle: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                  smallSize: 20,
                  label: Text(userCartLength.toString()),
                  // isLabelVisible: false,
                  child: const Icon(Icons.shopping_cart_outlined),
                ),
              )),
        ],
      ),
    );
  }
}
