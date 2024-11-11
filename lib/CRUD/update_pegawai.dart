// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healthy/api/constan.dart';
import 'package:http/http.dart' as http;

class UpdateEmployee extends StatefulWidget {
  final int id;

  const UpdateEmployee({super.key, required this.id});

  @override
  // ignore: library_private_types_in_public_api
  _UpdateEmployee createState() => _UpdateEmployee();
}

class _UpdateEmployee extends State<UpdateEmployee> {
  TextEditingController namaController = TextEditingController();
  TextEditingController noBpController = TextEditingController();
  TextEditingController noHpController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchDataPegawai();
  }

  Future<void> fetchDataPegawai() async {
    try {
      final response =
          await http.get(Uri.parse(BaseUrl.ReadPegawai + '?id=${widget.id}'));
      final responseData = json.decode(response.body);

      if (responseData['isSuccess']) {
        final pegawai = responseData['data'];

        setState(() {
          namaController.text = pegawai['nama'].toString();
          noBpController.text = pegawai['no_bp'].toString();
          noHpController.text = pegawai['no_telp'].toString();
          emailController.text = pegawai['email'].toString();
        });
      } else {
        print('Gagal: ${responseData['message']}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> updatePegawai() async {
    try {
      final response = await http.post(
        Uri.parse(BaseUrl.updatePegawai),
        body: {
          'id': widget.id.toString(),
          'nama': namaController.text,
          'no_bp': noBpController.text,
          'no_telp': noHpController.text,
          'email': emailController.text,
        },
      );

      final responseData = json.decode(response.body);
      if (responseData['isSuccess']) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Berhasil'),
              content: Text('Data pegawai berhasil diperbarui.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Tutup dialog
                    Navigator.pop(
                        context, true); // Kembali ke halaman sebelumnya
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        print('Pegawai gagal diperbarui');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Pegawai'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: namaController,
              decoration: InputDecoration(labelText: 'Nama'),
            ),
            TextField(
              controller: noBpController,
              decoration: InputDecoration(labelText: 'No. BP'),
            ),
            TextField(
              controller: noHpController,
              decoration: InputDecoration(labelText: 'No. HP'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                updatePegawai(); // Panggil metode updatePegawai saat tombol ditekan
              },
              child: Text('Simpan Perubahan'),
            ),
          ],
        ),
      ),
    );
  }
}
