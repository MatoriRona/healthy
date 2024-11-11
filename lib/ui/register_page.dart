import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healthy/api/constan.dart';
import 'package:healthy/ui/login_page.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _registerUser() async {
    final url = BaseUrl.register; 

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'fullname': _fullnameController.text,
          'username': _usernameController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
        },
      );

      final responseData = json.decode(response.body);
      
      if (responseData['value'] == 1) {
        // Registrasi berhasil, navigasi ke halaman login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } else {
        // Registrasi gagal, tampilkan pesan kesalahan
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(responseData['message']),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      print('Error registering: $error');
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Image(
                image: AssetImage("images/splash.jpeg"),
                height: 150,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Register To App HealthCare",
              style: TextStyle(
                color: Colors.green,
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _fullnameController,
                decoration: InputDecoration(
                  fillColor: Colors.green.withOpacity(0.3),
                  filled: true,
                  hintText: "FULLNAME",
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  fillColor: Colors.green.withOpacity(0.3),
                  filled: true,
                  hintText: "USERNAME",
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  fillColor: Colors.green.withOpacity(0.3),
                  filled: true,
                  hintText: "EMAIL",
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  fillColor: Colors.green.withOpacity(0.3),
                  filled: true,
                  hintText: "PASSWORD",
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green
                ),
                onPressed: _registerUser,
                child: const Text(
                  "Register",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          },
          child: const Text(
            "Anda sudah punya akun, silahkan login",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
