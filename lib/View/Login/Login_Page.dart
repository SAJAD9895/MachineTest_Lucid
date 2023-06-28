import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:machine_test/View/Home_pages/Home_Page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Controller/Change_Page.dart';

import '../../Controller/Color_Controller.dart';
import '../Signup/Signup_Page.dart';
import 'dart:async';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greentheme,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: greentheme),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 1.2,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 33, top: 30, bottom: 28),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.only(right: 33, left: 33, bottom: 34),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [BoxShadow(blurRadius: 10)],
                      borderRadius: BorderRadius.circular(10),
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    child: TextField(
                      controller: _emailcontroller,
                      // textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.email_outlined),
                        suffixIconColor: Colors.black,
                        hintText: '  Email',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 33, left: 33),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [BoxShadow(blurRadius: 10)],
                      borderRadius: BorderRadius.circular(10),
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    child: TextField(
                      controller: _passwordcontroller,
                      // textAlign: TextAlign.left,
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.remove_red_eye),
                        suffixIconColor: Colors.black,
                        hintText: '  Password',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 61,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          signInWithEmailPassword(_emailcontroller.text,
                              _passwordcontroller.text, context);
                        },
                        child: Container(
                          height: 47,
                          width: 261,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: greentheme),
                          child: const Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 25,
                      ),
                      const Text('Donot have account'),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const SignUp()));
                        },
                        child: const Text('Signup'),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> signInWithEmailPassword(
      String email, String password, context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      replacementPushing(const Home_Page(), context);
      User? user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // Handle user not found error
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('user-not-found')));
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        // Handle wrong password error
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('wrong-password')));
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      // Handle other exceptions
      print('Error occurred during sign in: $e');
    }
  }
}
