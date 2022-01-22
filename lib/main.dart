import 'package:flutter/material.dart';
import 'package:onye_front_ened/pages/Login/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Onye',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: const login_page(),
    );
  }
}


