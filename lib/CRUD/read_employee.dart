// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healthy/CRUD/update_pegawai.dart';
import 'package:healthy/api/constan.dart';
import 'package:healthy/ui/detail_employee.dart';
import 'package:http/http.dart' as http;

class EmployeePage extends StatefulWidget {
  @override
  _EmployeePageState createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  List<dynamic> pegawaiList = [];
  bool _isLoading = false;

  Future<void> fetchDataPegawai() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final response = await http.get(Uri.parse(BaseUrl.ReadPegawai));
      final responseData = json.decode(response.body);

      if (responseData['isSuccess']) {
        setState(() {
          _isLoading = false;
          pegawaiList = responseData['data'];
        });
      } else {
        print('Gagal: ${responseData['message']}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> deletePegawai(int id) async {
    try {
      final response = await http.post(
        Uri.parse(BaseUrl.DeletePegawai),
        body: {'id': id.toString()},
      );

      final responseData = json.decode(response.body);
      if (responseData['isSuccess']) {
        // Pegawai berhasil dihapus
        print('Pegawai berhasil dihapus');
        fetchDataPegawai(); // Memuat ulang data setelah penghapusan

        // Tampilkan dialog berhasil dihapus
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Sukses'),
              content: Text('Pegawai berhasil dihapus'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Tutup dialog
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // Pegawai gagal dihapus
        print('Pegawai gagal dihapus');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> showDeleteConfirmationDialog(int id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User harus menekan tombol untuk keluar
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Hapus'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Apakah Anda yakin ingin menghapus data pegawai ini?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Tidak'),
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
            ),
            TextButton(
              child: Text('Ya'),
              onPressed: () {
                deletePegawai(id);
                Navigator.of(context).pop(); // Tutup dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    fetchDataPegawai();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
          onRefresh: () async {
            fetchDataPegawai();
          },
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: pegawaiList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final pegawai = pegawaiList[index];
                    return Card(
                      elevation: 2.0,
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailEmployee(
                                nama: pegawai['nama'],
                                no_bp: pegawai['no_bp'],
                                no_telp: pegawai['no_telp'],
                                tgl_input: pegawai['tgl_input'],
                              ),
                            ),
                          );
                        },
                        // title: Text('ID: ${pegawai['id']}'),
                        leading: Icon(
                          Icons.person_pin,
                          color: Colors.green,
                          size: 40,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${pegawai['nama']}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            Text('${pegawai['no_bp']}'),
                            // Text('No. HP: ${pegawai['no_telp']}'),
                            // Text('Email: ${pegawai['email']}'),
                            // Text('Email: ${pegawai['tgl_input']}'),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdateEmployee(
                                        id: int.parse(pegawai['id'])),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                final id =
                                    int.tryParse(pegawai['id'].toString());
                                if (id != null) {
                                  showDeleteConfirmationDialog(id);
                                } else {
                                  print('Invalid ID: ${pegawai['id']}');
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )),
    );
  }
}
