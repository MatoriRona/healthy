import 'package:flutter/material.dart';

import 'edit_profile_user.dart';
import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  final int id;
  final String username;
  final String email;

  const ProfilePage({
    super.key,
    required this.id,
    required this.username,
    required this.email,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // late String username = ''; // Inisialisasi username dengan nilai awal kosong
  // late String email = ''; // Inisialisasi email dengan nilai awal kosong
  bool isLoading = false;

  Future<void> logout() async {
    // Implementasi proses logout di sini
    // Misalnya, menghapus data pengguna yang disimpan secara lokal
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.clear();

    // Setelah proses logout selesai, navigasikan pengguna ke halaman login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    ); // Ganti '/login' dengan rute halaman login Anda
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil User'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  const CircleAvatar(
                    backgroundImage: AssetImage("images/doctor.png"),
                    radius: 80,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.username,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.email,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfileUser(
                            id: widget.id,
                          ),
                        ),
                      );
                    },
                    child: const Text('Edit Profile'),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      logout();
                    },
                    child: const Text('Logout'),
                  ),
                ],
              ),
            ),
    );
  }
}
