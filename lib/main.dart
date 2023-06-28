import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:machine_test/Controller/Data_Provider.dart';
import 'package:machine_test/View/Login/Login_Page.dart';
import 'package:machine_test/View/SplashScreen.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( options: DefaultFirebaseOptions.currentPlatform,);
  runApp(
    MultiProvider(providers: [ ChangeNotifierProvider(
          create: (context) => Data_provider(),
        ),],
  child:  const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  SplashScreen(),
    )));
}
