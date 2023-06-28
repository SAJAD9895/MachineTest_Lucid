import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:machine_test/View/Login/Login_Page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Controller/Change_Page.dart';
import '../../Controller/Color_Controller.dart';

logOut(BuildContext context) {
  AlertDialog alert = AlertDialog(
    backgroundColor: Colors.white,
    scrollable: true,
    title: const Text(
      "Are you sure?",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    ),
    content: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 35,
                width: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: greentheme),
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                child: TextButton(
                    child: Text('YES', style: TextStyle(color: Colors.black)),
                    onPressed: ()async {
                      FirebaseAuth auth = FirebaseAuth.instance;
                      auth.signOut();
                        
                      replacementPushing(const LogIn(), context);
                    }),
              ),
              Container(
                height: 35,
                width: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: greentheme),
                  color: greentheme,
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                child: TextButton(
                    child: Text(
                      'NO',
                      style: TextStyle(color: white),
                    ),
                    onPressed: () {
                      poping(context);
                    }),
              ),
            ],
          ),
        ],
      ),
    ),
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
