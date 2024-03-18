import 'dart:io';
import 'dart:convert';
import 'package:bounce/bounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:galeri_foto/halaman_album/blue_button.dart';
import 'package:galeri_foto/halaman_album/lihat_album.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:galeri_foto/halaman_album/textfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:galeri_foto/api.dart';

class TambahFoto extends StatefulWidget {
  final String albumId, userId, namaAlbum, deskripsiAlbum;
  const TambahFoto({
    super.key,
    required this.albumId,
    required this.userId,
    required this.namaAlbum,
    required this.deskripsiAlbum,
  });

  @override
  State<TambahFoto> createState() => _TambahFotoState();
}

class _TambahFotoState extends State<TambahFoto> {
  TextEditingController judulFoto = TextEditingController();
  TextEditingController deskripsiFoto = TextEditingController();
  bool aksesPenyimpanan = false;
  bool simpanPressed = false;

  Future mintaAkes() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      await Permission.storage.request();
    } else {
      aksesPenyimpanan = true;
    }
  }

  File? fileFoto;

  Future pilihFoto() async {
    final foto = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (foto != null) {
      setState(() {
        fileFoto = File(foto.path);
      });
    }
  }

  Future unggahFoto(File foto, String albumId, userId) async {
    final uri = Uri.parse(uploadFoto);
    final bytesFoto = await foto.readAsBytes();
    String base64Foto = base64Encode(bytesFoto);
    final response = await http.post(
      uri,
      body: {
        'judulfoto': judulFoto.text,
        'deskripsifoto': deskripsiFoto.text,
        'foto': base64Foto,
        'albumid': albumId,
        'userid': userId,
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
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return LihatAlbum(
                              albumId: widget.albumId,
                              userId: widget.userId,
                              namaAlbum: widget.namaAlbum,
                              deskripsiAlbum: widget.deskripsiAlbum,
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
                  fileFoto != null
                      ? Container(
                          margin: const EdgeInsets.fromLTRB(25, 0, 25, 50),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              width: 2,
                              color: const Color.fromRGBO(54, 76, 225, 0.3),
                            ),
                          ),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                ),
                                child: fileFoto != null
                                    ? Image.file(
                                        fileFoto!,
                                        width: MediaQuery.sizeOf(context).width,
                                        fit: BoxFit.cover,
                                      )
                                    : const SizedBox(),
                              ),
                              const SizedBox(height: 25),
                              widgetTextField(
                                judulFoto,
                                'Judul Foto',
                              ),
                              const SizedBox(height: 25),
                              widgetTextField(
                                deskripsiFoto,
                                'Deskripsi Foto',
                              ),
                              const SizedBox(height: 25),
                              simpanPressed ? const SizedBox() : Bounce(
                                tilt: false,
                                onTap: () {
                                  if (fileFoto != null) {
                                    if (simpanPressed) {
                                      //
                                    } else {
                                      unggahFoto(
                                        fileFoto!,
                                        widget.albumId.toString(),
                                        widget.userId,
                                      );
                                      setState(() {
                                        simpanPressed = true;
                                      });
                                      Future.delayed(
                                        const Duration(seconds: 10),
                                        () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return LihatAlbum(
                                                  albumId: widget.albumId,
                                                  userId: widget.userId,
                                                  namaAlbum: widget.namaAlbum,
                                                  deskripsiAlbum:
                                                      widget.deskripsiAlbum,
                                                );
                                              },
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  } else {
                                    //
                                  }
                                },
                                child: BlueButton(
                                  width: MediaQuery.sizeOf(context).width * 0.8,
                                  height: 50.0,
                                  text: 'Simpan',
                                ),
                              ),
                              const SizedBox(height: 25),
                            ],
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Bounce(
                              tilt: false,
                              onTap: () {
                                if (aksesPenyimpanan = false) {
                                  mintaAkes();
                                } else {
                                  pilihFoto();
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: MediaQuery.sizeOf(context).width * 0.9,
                                height: MediaQuery.sizeOf(context).height * 0.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    width: 2,
                                    color:
                                        const Color.fromRGBO(54, 76, 225, 0.3),
                                  ),
                                ),
                                child: const Text(
                                  'Tambah Foto',
                                  style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 25,
                                    color: Color.fromRGBO(54, 76, 225, 1),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                  simpanPressed
                      ? const Center(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 25),
                              CircularProgressIndicator(
                                color: Color.fromRGBO(54, 76, 225, 1),
                              ),
                              SizedBox(height: 25),
                              Text(
                                'Sedang mengunggah foto',
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                      )
                      : const SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
