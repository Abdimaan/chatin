// login_screen.dart

import 'package:flutter/material.dart';
import 'package:chatin/welcome_screen.dart';
import 'package:chatin/roundedbutton.dart';
import 'package:chatin/constant_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatin/chat_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  // Constructor
  //const LoginScreen({super.key});
  const LoginScreen({super.key});

  // Getter
  Widget get loginScreen => const LoginScreen();

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passwordVisible = false;
  late String email;
  late String password;
  final _autho = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 200.0,
              child: Flexible(
                  child:
                      Hero(tag: 'logo', child: Image.asset('images/logo.png'))),
            ),
            const SizedBox(
              height: 48.0,
            ),
            // Email field
            Row(
              children: <Widget>[
                const Text(
                  'Email:      ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _emailController,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value;
                    },
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.normal,
                    ),
                    decoration: ktextfeild.copyWith(
                      hintText: 'Enter your email',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            // Password field
            Row(
              children: <Widget>[
                const Text(
                  'Password:',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _passwordController,
                    textAlign: TextAlign.center,
                    obscureText: !_passwordVisible,
                    onChanged: (value) {
                      password = value;
                    },
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.normal,
                    ),
                    decoration: ktextfeild.copyWith(
                      hintText: 'Enter your password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24.0,
            ),
            RoundedButton(
              colour: Colors.lightBlueAccent,
              title: 'Log in',
              onPress: () async {
                try {
                  final newuser = await _autho.signInWithEmailAndPassword(
                      email: email, password: password);
                  // ignore: unnecessary_null_comparison
                  if (newuser != null) {
                    _emailController.clear();
                    _passwordController.clear();
                    Navigator.pushNamed(context, ChatScreen.id);
                  }
                } catch (e) {
                  print(e);
                }
              },
            ),
            RoundedButton(
              colour: Colors.blueAccent,
              title: 'Back home',
              onPress: () {
                Navigator.pushNamed(context, WelcomeScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
