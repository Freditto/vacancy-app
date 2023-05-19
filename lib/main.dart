import 'package:flutter/material.dart';
import 'package:vacancies_app/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
      // routes: {
      //   LoginScreen.id: (context) => const LoginScreen(),
      //   SignupScreen.id: (context) => const SignupScreen(),
      //   MainScreen.id: (context) => const MainScreen(),
      //   HomeScreen.id: (context) => const HomeScreen(),
      //   CartScreen.id: (context) => const CartScreen(),
      // },
    );
  }
}