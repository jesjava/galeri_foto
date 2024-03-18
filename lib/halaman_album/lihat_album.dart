import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:galeri_foto/dashboard.dart';
import 'package:galeri_foto/halaman_album/edit_foto.dart';
import 'package:galeri_foto/halaman_album/tambah_foto.dart';
import 'package:galeri_foto/halaman_album/textfield.dart';
import 'package:galeri_foto/halaman_album/blue_button.dart';
import 'package:http/http.dart' as http;
import 'package:galeri_foto/api.dart';

class LihatAlbum extends StatefulWidget {
  final String albumId, userId, namaAlbum, deskripsiAlbum;
  const LihatAlbum({
    super.key,
    required this.albumId,
    required this.userId,
    required this.namaAlbum,
    required this.deskripsiAlbum,
  });

  @override
  State<LihatAlbum> createState() => _LihatAlbumState();
}

class _LihatAlbumState extends State<LihatAlbum> {
  TextEditingController namaAlbum = TextEditingController();
  TextEditingController deskripsiAlbum = TextEditingController();

  List<dynamic> albumData = [];

  Future lihatAlbum(String albumId) async {
    final response = await http.post(
      Uri.parse(urlLihatAlbum),
      body: {
        'albumid': albumId,
      },
    );
    if (response.statusCode == 200) {
      setState(() {
        albumData = json.decode(response.body);
      });
    } else {
      //
    }
  }

  Future updateAlbum(String albumId, namaAlbum, deskripsiAlbum) async {
    var response = await http.post(
      Uri.parse(urlUpdateAlbum),
      body: {
        'albumid': albumId,
        'namaalbum': namaAlbum,
        'deskripsialbum': deskripsiAlbum,
      },
    );
    if (response.statusCode == 200) {
      //
    } else {
      //
    }
  }

  Future hapusFoto(String fotoId) async {
    var response = await http.post(
      Uri.parse(urlHapusFoto),
      body: {
        'fotoid': fotoId,
      },
    );
    if (response.statusCode == 200) {
      //
    } else {
      //
    }
  }

  @override
  void initState() {
    super.initState();
    lihatAlbum(widget.albumId);
    namaAlbum.text = widget.namaAlbum;
    deskripsiAlbum.text = widget.deskripsiAlbum;
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
                  widgetTextField(namaAlbum, 'Nama Album'),
                  const SizedBox(height: 25),
                  widgetTextField(deskripsiAlbum, 'Deskripsi'),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      const SizedBox(width: 15),
                      GestureDetector(
                        onTap: () {
                          if (namaAlbum.text.isEmpty ||
                              deskripsiAlbum.text.isEmpty) {
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return TambahFoto(
                                    albumId: widget.albumId,
                                    userId: widget.userId,
                                    namaAlbum: namaAlbum.text,
                                    deskripsiAlbum: deskripsiAlbum.text,
                                  );
                                },
                              ),
                            );
                          }
                        },
                        child: const BlueButton(
                          width: 150.0,
                          height: 45.0,
                          text: 'Tambah Foto',
                        ),
                      ),
                      const SizedBox(width: 25),
                      GestureDetector(
                        onTap: () {
                          if (namaAlbum.text.isEmpty ||
                              deskripsiAlbum.text.isEmpty) {
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
                            updateAlbum(
                              widget.albumId,
                              namaAlbum.text,
                              deskripsiAlbum.text,
                            );
                            const snackBarSimpan = SnackBar(
                              content: Text(
                                'Simpan berhasil',
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              snackBarSimpan,
                            );
                          }
                        },
                        child: const BlueButton(
                          width: 125.0,
                          height: 45.0,
                          text: 'Simpan',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: albumData.length,
              itemBuilder: (context, index) {
                var item = albumData[index];
                return Container(
                  margin: const EdgeInsets.fromLTRB(15, 25, 15, 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      item['LokasiFile'] == null
                          ? const SizedBox()
                          : Text(
                              item['JudulFoto'],
                              style: const TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: item['LokasiFile'] == null
                            ? const SizedBox()
                            : Image.memory(
                                base64Decode(item['LokasiFile']),
                                width: MediaQuery.sizeOf(context).width,
                                fit: BoxFit.cover,
                              ),
                      ),
                      const SizedBox(height: 10),
                      item['LokasiFile'] == null
                          ? const SizedBox()
                          : GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return EditFoto(
                                        albumId: widget.albumId,
                                        userId: widget.userId,
                                        fotoId: item['FotoID'].toString(),
                                        judulFoto: item['JudulFoto'],
                                        deskripsiFoto: item['DeskripsiFoto'],
                                        lokasiFile: item['LokasiFile'],
                                        namaAlbum: item['NamaAlbum'],
                                        deskripsiAlbum: item['Deskripsi'],
                                      );
                                    },
                                  ),
                                );
                              },
                              child: BlueButton(
                                width: MediaQuery.sizeOf(context).width,
                                height: 45.0,
                                text: 'Ubah',
                              ),
                            ),
                      const SizedBox(height: 10),
                      item['LokasiFile'] == null
                          ? const SizedBox()
                          : GestureDetector(
                              onTap: () {
                                final snackBarHapus = SnackBar(
                                  content: const Text(
                                    'Apakah anda yakin?',
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                  action: SnackBarAction(
                                    label: 'Hapus',
                                    onPressed: () {
                                      hapusFoto(item['FotoID'].toString());
                                      setState(() {
                                        albumData.removeAt(index);
                                      });
                                    },
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBarHapus);
                              },
                              child: BlueButton(
                                width: MediaQuery.sizeOf(context).width,
                                height: 45.0,
                                text: 'Hapus Foto',
                              ),
                            ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
