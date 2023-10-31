import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BelowAppBar extends StatelessWidget {
  const BelowAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;

    return Container(
      decoration: const BoxDecoration(gradient: GlobalVariables.appBarGradient),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          RichText(
              text: TextSpan(children: [
            const TextSpan(
                text: "Hello, ",
                style: TextStyle(color: Colors.black, fontSize: 22)),
            TextSpan(
                text: user.name,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 22)),
          ])),
        ],
      ),
    );
  }
}
