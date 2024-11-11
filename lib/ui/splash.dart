import 'dart:async';

import 'package:flutter/material.dart';
import 'package:healthy/ui/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/splahs.jpeg"),
          ),
        ),
        child: const Center(
          child: Text(
            "Welcome to healthy care",
            style: TextStyle(
              fontSize: 30,
              color: Colors.deepPurple,
              fontWeight: FontWeight.w800
            ),
          ),
        ),
      ),
    );
  }
}
