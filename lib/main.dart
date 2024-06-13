// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:hotel_app/screens/login.dart';
import 'screens/root_app.dart';
import 'theme/color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hotel Booking',
      theme: ThemeData(
        primaryColor: AppColor.primary,
      ),
      home: const LoginPage(),
      routes: {
        '/Login': (context) => const LoginPage(),
      },
    );
  }
}
