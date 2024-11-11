import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healthy/api/constan.dart';
import 'package:http/http.dart' as http;

import 'detail_berita.dart';

class BeritaPage extends StatefulWidget {
  @override
  _BeritaPageState createState() => _BeritaPageState();
}

class _BeritaPageState extends State<BeritaPage> {
  List<dynamic> beritaList = [];
  List<dynamic> filteredBeritaList = [];
  bool _isLoading = false;

  TextEditingController searchController = TextEditingController();

  Future<void> fetchBerita() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await http.get(Uri.parse(BaseUrl.getBerita));
      final responseData = json.decode(response.body);
      if (responseData['isSuccess']) {
        setState(() {
          _isLoading = false;
          beritaList = responseData['data'];
          filteredBeritaList = beritaList;
        });
      } else {
        print('Gagal: ${responseData['message']}');
      }
    } catch (error) {
      print('Error: $error');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchBerita();
  }

  void filterBerita(String query) {
  List<dynamic> filteredBerita = [];
  if (query.isEmpty) {
    setState(() {
      // Jika query kosong, kembalikan filteredBeritaList ke nilai beritaList
      filteredBeritaList = beritaList;
    });
  } else {
    // Jika query tidak kosong, filter data sesuai dengan query
    filteredBeritaList.forEach((berita) {
      if (berita['judul'].toLowerCase().contains(query.toLowerCase())) {
        filteredBerita.add(berita);
      }
    });
    setState(() {
      filteredBeritaList = filteredBerita;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: Column(
        children: [
          _buildSearchBox(),
          _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: filteredBeritaList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPage(
                                konten: filteredBeritaList[index]['konten'],
                                gambar:
                                    filteredBeritaList[index]['gambar'], pegawai: null,
                              ),
                            ),
                          );
                        },
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            BaseUrl.gambar +
                                filteredBeritaList[index]['gambar'],
                          ),
                          radius: 30,
                        ),
                        title: Text(
                          filteredBeritaList[index]['judul'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          filteredBeritaList[index]['konten'],
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildSearchBox() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.green.withOpacity(0.3),
        ),
        child: TextField(
          controller: searchController,
          onChanged: filterBerita,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black.withOpacity(0.6),
            ),
            hintText: "Search Berita...",
            hintStyle: TextStyle(
              color: Colors.black.withOpacity(0.6),
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
