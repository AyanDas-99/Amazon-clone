import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_form_field.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/auth/services/auth_services.dart';
import 'package:flutter/material.dart';

enum Auth {
  signin,
  signup,
}

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  final AuthServices authServices = AuthServices();

  void signIn() {
    authServices.signInUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text);
  }

  void signUp() {
    authServices.signUpUser(
        context: context,
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              'Welcome',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
            ),
            ListTile(
              tileColor: (_auth == Auth.signup)
                  ? GlobalVariables.backgroundColor
                  : GlobalVariables.greyBackgroundColor,
              title: const Text(
                'Create Account',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: Radio(
                value: Auth.signup,
                groupValue: _auth,
                onChanged: (Auth? value) {
                  setState(() {
                    _auth = value!;
                  });
                },
              ),
            ),
            if (_auth == Auth.signup)
              Container(
                color: GlobalVariables.backgroundColor,
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: _signUpFormKey,
                  child: Column(
                    children: [
                      CustomFormField(
                        controller: _nameController,
                        hintText: 'Name',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomFormField(
                        controller: _emailController,
                        hintText: 'Email',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomFormField(
                        controller: _passwordController,
                        hintText: 'Password',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                          text: 'Sign Up',
                          onTap: () {
                            if (_signUpFormKey.currentState!.validate()) {
                              signUp();
                            }
                          }),
                    ],
                  ),
                ),
              ),
            ListTile(
              tileColor: (_auth == Auth.signin)
                  ? GlobalVariables.backgroundColor
                  : GlobalVariables.greyBackgroundColor,
              title: const Text(
                'Sign-in.',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: Radio(
                value: Auth.signin,
                groupValue: _auth,
                onChanged: (Auth? value) {
                  setState(() {
                    _auth = value!;
                  });
                },
              ),
            ),
            if (_auth == Auth.signin)
              Container(
                color: GlobalVariables.backgroundColor,
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: _signInFormKey,
                  child: Column(
                    children: [
                      CustomFormField(
                        controller: _emailController,
                        hintText: 'Email',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomFormField(
                        controller: _passwordController,
                        hintText: 'Password',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                          text: 'Sign In',
                          onTap: () {
                            if (_signInFormKey.currentState!.validate()) {
                              signIn();
                            }
                          }),
                    ],
                  ),
                ),
              )
          ],
        ),
      )),
    );
  }
}
