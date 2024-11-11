import 'package:flutter/material.dart';
import 'package:healthy/api/constan.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.konten, required this.gambar, required pegawai});
  final String konten;
  final String gambar;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  // void back() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  //   sharedPreferences.clear();
  //   Navigator.pushAndRemoveUntil(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => MenuPage(),
  //       ),
  //       (route) => false);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // leading: IconButton(
        //     onPressed: () {
        //       // back();
        //     },
        //     icon: Icon(
        //       Icons.arrow_back_ios_new_rounded,
        //       size: 20,
        //     )),
      ),
      body: ListView(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(BaseUrl.gambar + widget.gambar),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Text(
            widget.konten,
            textAlign: TextAlign.justify,
          ),
          Text(
            widget.konten,
            textAlign: TextAlign.justify,
          ),
          Text(
            widget.konten,
            textAlign: TextAlign.justify,
          ),
          Text(
            widget.konten,
            textAlign: TextAlign.justify,
          ),
          Text(
            widget.konten,
            textAlign: TextAlign.justify,
          ),
          Text(
            widget.konten,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
