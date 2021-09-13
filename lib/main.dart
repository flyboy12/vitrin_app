import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vitrin_app/screens/home_screen.dart';

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
      title: 'Vitrin',
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      theme: ThemeData.dark().copyWith(
        backgroundColor: Colors.grey[700],
        appBarTheme: AppBarTheme(
            elevation: 0.0, color: Colors.transparent, centerTitle: true),
      ),
      home: HomePage(),
    );
  }
}
