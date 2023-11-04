import 'package:amazon_clone/common/widgets/custom_form_field.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  TextEditingController areaController = TextEditingController();
  TextEditingController flatBuidingController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    areaController.dispose();
    flatBuidingController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final address = context.watch<UserProvider>().user.address;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _addressFormKey,
          child: Column(
            children: [
              if (address.isNotEmpty) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                    ),
                  ),
                  child: Text(
                    address,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "OR",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
              ],
              CustomFormField(
                controller: flatBuidingController,
                hintText: 'Flat, House no, Building',
              ),
              const SizedBox(
                height: 10,
              ),
              CustomFormField(
                controller: areaController,
                hintText: 'Area, Street',
              ),
              const SizedBox(
                height: 10,
              ),
              CustomFormField(
                controller: pincodeController,
                hintText: 'Pincode',
              ),
              const SizedBox(
                height: 10,
              ),
              CustomFormField(
                controller: cityController,
                hintText: 'Town/City',
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
