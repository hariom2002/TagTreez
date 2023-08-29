import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:forest_tagger/components/AuthHandler.dart';

import 'components/WelComePage.dart';
import 'components/backButton.dart';
import 'components/generatorPage.dart';
import 'components/homeScreen.dart';
import 'components/logIn.dart';
import 'components/qrshower.dart';
import 'components/scannerPage.dart';
import 'components/signUp.dart';
import 'components/treeListItem.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomeScreen("hari"),
    );
  }
}
