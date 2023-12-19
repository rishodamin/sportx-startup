import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:sportx/common/widgets/bottom_bar.dart';
import 'package:sportx/constants/error_handling.dart';
import 'package:sportx/constants/global_variables.dart';
import 'package:sportx/constants/utils.dart';
import 'package:sportx/models/user_models/user.dart' as user_model;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportx/providers/user_provider.dart';

class AuthService {
  //sign up user
  Future<void> signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    bool fromGoogleSignUp = false,
  }) async {
    try {
      user_model.User user = user_model.User(
        id: '',
        name: name,
        password: password,
        address: [],
        type: '',
        token: '',
        email: email,
        cart: [],
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: jsonEncode(user.toJson()),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );

      if (!fromGoogleSignUp) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(
                context, 'Account created!! Login with the same credentials');
          },
        );
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //sign up user
  Future<void> signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          Navigator.pushNamedAndRemoveUntil(
            context,
            BottomBar.routeName,
            (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // get uder data
  Future<void> getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
        token = '';
      }

      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'x-auth-token': token,
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'x-auth-token': token,
          },
        );

        Provider.of<UserProvider>(context, listen: false).setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // sign in with google
  Future<void> signInWithGoogle({
    required BuildContext context,
  }) async {
    try {
      // begin interactive sign in process
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      // obtain auth details from req
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;

      // create a new cred for user
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      // finally, let's sign in
      UserCredential userCred =
          await FirebaseAuth.instance.signInWithCredential(credential);
      String name, email, password;
      name = userCred.user!.displayName!;
      email = 'google${userCred.user!.uid}@gmail.com';
      password = userCred.user!.uid;
      signUpUser(
        context: context,
        email: email,
        password: password,
        name: name,
        fromGoogleSignUp: true,
      ).then((_) async {
        await signInUser(
          context: context,
          email: email,
          password: password,
        );
      });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
