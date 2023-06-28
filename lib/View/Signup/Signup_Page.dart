import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:machine_test/Controller/Color_Controller.dart';

import 'package:machine_test/View/Login/Login_Page.dart';
// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Controller/firebase_contants.dart';


class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {


  final TextEditingController _userEmail = TextEditingController();
  final TextEditingController _userpassword = TextEditingController();
 
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
              decoration:
                   BoxDecoration(color: greentheme),
              
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
                      'SignUp',
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
                      controller: _userEmail,
                      
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
                      controller: _userpassword,
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
                       
                       
                        signUp(
                        userEmail: _userEmail.text,
                        password: _userpassword.text,
                        context: context);
                        },
                        child: Container(
                          height: 47,
                          width: 261,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromRGBO(47, 181, 140, 1)),
                          child: const Center(
                            child: Text(
                              'Signup',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          ),
                        ),
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
    static Future<User?> signUp(
      {required String userEmail,
      required String password,
      required BuildContext context}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: userEmail, password: password);
      print(userCredential.user);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => LogIn()));
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('The password provided is too weak.')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('The account already exists for that email.')));
      }
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}



// class Signup_Page extends StatelessWidget {
//   Signup_Page({super.key});
//   TextEditingController _emailcontroller = TextEditingController();
//   TextEditingController _passwordcontroller = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//         ),
//         body: SingleChildScrollView(
//           child: Center(
//             child: Padding(
//               padding: const EdgeInsets.all(15),
//               child: Column(children: [
//                 SizedBox(
//                   height: height / 4,
//                 ),
//                 TextField(
//                   decoration: InputDecoration(hintText: 'Enter your email'),
//                   controller: _emailcontroller,
//                 ),
//                 _space,
//                 TextField(
//                   decoration: InputDecoration(hintText: 'Enter your password'),
//                   controller: _passwordcontroller,
//                 ),
//                 _space,
//                 ElevatedButton(
//                   onPressed: () {
//                     print('signup start');
//                     signUp(
//                         userEmail: _emailcontroller.text,
//                         password: _passwordcontroller.text,
//                         context: context);
//                   },
//                   child: Text('Signup'),
//                 ),
//                 _space,
            
//               ]),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   final Widget _space = const SizedBox(
//     height: 15,
//   );
//   static Future<User?> signUp(
//       {required String userEmail,
//       required String password,
//       required BuildContext context}) async {
//     try {
//       UserCredential userCredential = await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(email: userEmail, password: password);
//       print(userCredential.user);
//       Navigator.of(context).pushReplacement(
//           MaterialPageRoute(builder: (BuildContext context) => LogIn()));
//       return userCredential.user;
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'weak-password') {
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//             content: Text('The password provided is too weak.')));
//       } else if (e.code == 'email-already-in-use') {
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//             content: Text('The account already exists for that email.')));
//       }
//       return null;
//     } catch (e) {
//       debugPrint(e.toString());
//       return null;
//     }
//   }
// }
