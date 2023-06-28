// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison, prefer_typing_uninitialized_variables, file_names

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:machine_test/Controller/Color_Controller.dart';
import 'package:machine_test/View/Home_pages/Home_Page.dart';
import 'package:machine_test/View/Login/Login_Page.dart';
import 'package:flutter/material.dart';
import '../Controller/Change_Page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      checkUser();
    });
  }

  void checkUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    // Check if user is null
    if (user == null) {
      // User is not logged in, navigate to login or registration screen
      // Example:
      replacementPushing(const LogIn(), context);
     
    } else {
      replacementPushing(const Home_Page(), context);
    
    }
  }

  var size, height, width;

  @override
  Widget build(BuildContext context) {
    // getting the size of the window
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(color: greentheme),
          child:const Center(
              child: Text(
            'HELLO',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          )),
        ),
      ),
    );
  }
}
