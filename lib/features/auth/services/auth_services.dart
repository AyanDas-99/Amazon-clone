import 'dart:convert';
import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  // Signup
  void signUpUser({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        email: email,
        password: password,
        address: '',
        type: '',
        token: '',
        cart: [],
      );

      http.Response response = await http.post(Uri.parse('$uri/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      if (context.mounted) {
        httpErrorHandle(
            response: response,
            context: context,
            onSuccess: () {
              showSnackBar(context,
                  'Account created! Sign in with the same credentials');
            });
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
  }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response response = await http.post(Uri.parse('$uri/api/signin'),
          body: jsonEncode({
            "email": email,
            "password": password,
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      print(response.body);

      if (context.mounted) {
        httpErrorHandle(
            response: response,
            context: context,
            onSuccess: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              if (context.mounted) {
                Provider.of<UserProvider>(context, listen: false)
                    .setUser(response.body);
                prefs.setString(
                    'x-auth-token', jsonDecode(response.body)['token']);
                Navigator.pushNamedAndRemoveUntil(
                    context, BottomBar.routeName, (route) => false);
              }
            });
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
  }

  void getUserData(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // Get token from local storage
      String? token = prefs.getString('x-auth-token');
      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      // Check if token is valid
      var tokenRes = await http.post(Uri.parse('$uri/tokenIsValid'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token!,
      });

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRef = await http.get(Uri.parse('$uri/'), headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        });

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRef.body);
      }
    } catch (e) {
      if (context.mounted) {
        print(e);
      }
    }
  }
}
