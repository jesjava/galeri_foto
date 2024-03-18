import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:galeri_foto/halaman_album/blue_button.dart';
import 'package:galeri_foto/halaman_profil/textfield.dart';
import 'package:http/http.dart' as http;
import 'package:galeri_foto/api.dart';
import 'package:galeri_foto/halaman_album/tambah_foto.dart';
import 'package:galeri_foto/dashboard.dart';

// ignore: must_be_immutable
class BuatAlbum extends StatefulWidget {
  String userId;
  BuatAlbum({
    super.key,
    required this.userId,
  });

  @override
  State<BuatAlbum> createState() => _BuatAlbumState();
}

class _BuatAlbumState extends State<BuatAlbum> {
  TextEditingController namaAlbumTEC = TextEditingController();
  TextEditingController deskripsiAlbumTEC = TextEditingController();

  Future buatAlbum(String namaAlbum, deskripsiAlbum, userId) async {
    final response = await http.post(
      Uri.parse(urlBuatAlbum),
      body: {
        'namaalbum': namaAlbum,
        'deskripsialbum': deskripsiAlbum,
        'userid': userId,
      },
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return TambahFoto(
              albumId: responseBody['album_id'].toString(),
              namaAlbum: namaAlbumTEC.text,
              deskripsiAlbum: deskripsiAlbumTEC.text,
              userId: widget.userId,
            );
          },
        ),
      );
    } else {
      //
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return DashboardWidget(
                              userId: widget.userId,
                            );
                          },
                        ),
                      );
                    },
                    child: const Row(
                      children: [
                        SizedBox(width: 15),
                        Icon(
                          CupertinoIcons.arrow_left,
                          color: Colors.black,
                          size: 30,
                        ),
                        SizedBox(width: 15),
                        Text(
                          'Kembali',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 25,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  widgetTextField(namaAlbumTEC, 'Nama Album'),
                  const SizedBox(height: 25),
                  widgetTextField(deskripsiAlbumTEC, 'Deskripsi'),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      const SizedBox(width: 15),
                      GestureDetector(
                        onTap: () {
                          if (namaAlbumTEC.text.isEmpty ||
                              deskripsiAlbumTEC.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'nama dan deskripsi album tidak boleh kosong',
                                  style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            buatAlbum(
                              namaAlbumTEC.text,
                              deskripsiAlbumTEC.text,
                              widget.userId,
                            );
                          }
                        },
                        child: const BlueButton(
                          width: 150.0,
                          height: 45.0,
                          text: 'Tambah',
                        ),
                      ),
                      const SizedBox(width: 25),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
