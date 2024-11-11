import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healthy/api/constan.dart';
import 'package:healthy/ui/register_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences package

import 'menu.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> saveUser(String id, String username, String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', id);
    await prefs.setString('username', username);
    await prefs.setString('email', email);
  }

  Future<Map<String, String>> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    String? email = prefs.getString('email');
    return {
      'username': username ?? '',
      'email': email ?? '',
    };
  }

  Future<void> _login() async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: const Text("Username dan password harus diisi."),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    } else {
      try {
        final response = await http.post(
          Uri.parse(BaseUrl.login),
          body: {
            'username': username,
            'password': password,
          },
        );

        if (response.statusCode == 200) {
          final responseData = json.decode(response.body);

          if (responseData['value'] == 1) {
            // Simpan username dan email ke Shared Preferences
            await saveUser(responseData['id'], username, responseData['email']);

            // Jika login berhasil, navigasi ke halaman MenuPage
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MenuPage(
                  username: username,
                  email: responseData['email'], // Tambahkan ini
                ),
              ),
            );
          } else {
            // Jika login gagal, tampilkan pesan kesalahan
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(responseData['message']),
              ),
            );
          }
        } else {
          // Jika terjadi kesalahan pada server, tampilkan pesan kesalahan
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Terjadi kesalahan saat melakukan login'),
            ),
          );
        }
      } catch (error) {
        // Tangani kesalahan koneksi atau kesalahan lainnya
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Terjadi kesalahan: $error'),
          ),
        );
      }
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   // Cek apakah pengguna sudah login sebelumnya
  //   getUser().then((userData) {
  //     // Jika pengguna sudah login, navigasi ke halaman MenuPage
  //     if (userData['username']!.isNotEmpty && userData['email']!.isNotEmpty) {
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => const MenuPage(),
  //         ),
  //       );
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Image(
              image: AssetImage("images/splash.jpeg"),
              height: 150,
            ),
          ),
          const Text(
            "Login To App HealthCare",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Colors.green,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
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
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _passwordController,
              obscureText: true, // Hide password
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
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: _login,
            child: const Text(
              'Login',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RegisterPage(),
            ),
          );
        },
        child: const Text(
          "Anda sudah punya akun silahkan login",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
