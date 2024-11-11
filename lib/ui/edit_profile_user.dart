import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healthy/api/constan.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileUser extends StatefulWidget {
  final int id;

  const EditProfileUser({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _EditProfileUserState createState() => _EditProfileUserState();
}

class _EditProfileUserState extends State<EditProfileUser> {
  TextEditingController _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? username = prefs.getString('username');

      if (username != null) {
        setState(() {
          _usernameController.text = username;
        });
      }
    } catch (error) {
      // Tangani kesalahan jika terjadi
    }
  }

  Future<void> updateData() async {
    final String newUsername = _usernameController.text.trim();
    if (newUsername.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username tidak boleh kosong')),
      );
      return;
    }

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', newUsername);

      // Update data pengguna di server
      final response = await http.post(
        Uri.parse(BaseUrl.updateUser), // Ganti dengan URL API Anda
        body: {
          'id': widget.id.toString(),
          'username': newUsername,
        },
      );

      // Periksa status kode response
      if (response.statusCode == 200) {
        // Pembaruan data berhasil
        final responseData = json.decode(response.body);
        // Lakukan tindakan sesuai kebutuhan, misalnya menampilkan pesan sukses
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['message'])),
        );
        // Clear teks pada TextFormField
        _usernameController.clear();

        // Tampilkan dialog konfirmasi
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Pembaruan Berhasil'),
              content: Text('Data pengguna berhasil diperbarui.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context); // Kembali ke halaman profil
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // Pembaruan data gagal, tampilkan pesan kesalahan
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal memperbarui data pengguna')),
        );
      }
    } catch (error) {
      // Tangani kesalahan jika terjadi
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Terjadi kesalahan saat memperbarui data pengguna')),
      );
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Username'),
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                hintText: 'Masukkan username baru',
              ),
            ),
            const SizedBox(height: 16.0),
            Center(
              child: ElevatedButton(
                onPressed: updateData,
                child: const Text('Simpan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
