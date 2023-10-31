import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressBox extends StatelessWidget {
  const AddressBox({super.key});

  @override
  Widget build(BuildContext context) {
    User user = context.watch<UserProvider>().user;
    return Container(
      height: 40,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 144, 226, 221),
            Color.fromARGB(225, 162, 236, 233),
          ],
          stops: [0.5, 1.0],
        ),
      ),
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Icon(
            Icons.location_on_outlined,
            size: 20,
          ),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    'Delivery to ${user.name} - ${user.address} Aerial Bay, Diglipur, North and Middle Andaman',
                    overflow: TextOverflow.ellipsis,
                  ))),
          const Padding(
            padding: EdgeInsets.only(top: 2, left: 5),
            child: Icon(
              Icons.arrow_drop_down_outlined,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }
}
