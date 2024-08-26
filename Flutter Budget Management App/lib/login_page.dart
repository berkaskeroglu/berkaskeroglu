import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:firebase_ui_oauth_twitter/firebase_ui_oauth_twitter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mybudgetapp/main.dart';
import 'package:provider/provider.dart';

import 'home.dart';
import 'user_provider.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    checkStatus();
  }
 
  void checkStatus() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        print("User is signed in: ${user.email}");
        Provider.of<UserProvider>(context, listen: false).setUser(
          user.uid,
          user.email!,
          user.displayName!,
          user.photoURL!,
        );
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
  }

  Future<void> sendUserDataToApi(User user) async {
    final url = Uri.parse('http://10.0.2.2:5229/api/Users');
    final headers = {"Content-Type": "application/json"};
    final body = json.encode({
      "uid": user.uid,
      "email": user.email,
      "displayName": user.displayName,
      "photoURL": user.photoURL
    });
    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        print('Success: ${response.body}');
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black87,
        title: const Text("Test"),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(30, 39, 46, 1),
              Color.fromRGBO(72, 84, 96, 1)
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              const SizedBox(height: 24),
              const Text(
                textAlign: TextAlign.center,
                'You may use the following providers for logging in',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              AuthStateListener<OAuthController>(
                child: OAuthProviderButton(
                  action: AuthAction.signIn,
                  provider: TwitterProvider(
                    ***,
                  ),
                ),
                listener: (oldState, newState, ctrl) {
                  if (newState is SignedIn) {
                    print("Twitter SignIn successful");
                    print("User: ${newState.user!.email}");
                    sendUserDataToApi(newState.user!);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                      (Route<dynamic> route) => false,
                    );
                  } else if (newState is UserCreated) {
                    final user = (newState as UserCreated).credential.user;
                    print("Twitter SignIn successful");
                    print("User: ${user!.email}");
                    sendUserDataToApi(user);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                      (Route<dynamic> route) => false,
                    );
                  } else {
                    print("Twitter SignIn failed or state is not SignedIn");
                    print("Current State: $newState");
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              AuthStateListener<OAuthController>(
                child: OAuthProviderButton(
                  action: AuthAction.signIn,
                  provider: GoogleProvider(
                    clientId: '*****',
                  ),
                ),
                listener: (oldState, newState, ctrl) {
                  if (newState is SignedIn) {
                    print("Google SignIn successful");
                    print("User: ${newState.user!.email}");
                    sendUserDataToApi(newState.user!);
                    Provider.of<UserProvider>(context, listen: false).setUser(
                      newState.user!.uid,
                      newState.user!.email!,
                      newState.user!.displayName!,
                      newState.user!.photoURL!,
                    );
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const MainApp()),
                      (Route<dynamic> route) => false,
                    );
                  } else if (newState is UserCreated) {
                    final user = (newState as UserCreated).credential.user;
                    print("Google SignIn successful");
                    print("User: ${user!.email}");
                    sendUserDataToApi(user);
                    Provider.of<UserProvider>(context, listen: false).setUser(
                      newState.credential.user!.uid,
                      newState.credential.user!.email!,
                      newState.credential.user!.displayName!,
                      newState.credential.user!.photoURL!,
                    );
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const MainApp()),
                      (Route<dynamic> route) => false,
                    );
                  } else {
                    print("Google SignIn failed or state is not SignedIn");
                    print("Current State: $newState");
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
