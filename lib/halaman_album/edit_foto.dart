import 'dart:convert';
import 'dart:io';
import 'package:bounce/bounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:galeri_foto/halaman_album/blue_button.dart';
import 'package:galeri_foto/halaman_album/lihat_album.dart';
import 'package:galeri_foto/halaman_album/textfield.dart';
import 'package:galeri_foto/api.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class EditFoto extends StatefulWidget {
  String albumId,
      userId,
      fotoId,
      judulFoto,
      deskripsiFoto,
      lokasiFile,
      namaAlbum,
      deskripsiAlbum;
  EditFoto({
    super.key,
    required this.albumId,
    required this.userId,
    required this.fotoId,
    required this.judulFoto,
    required this.deskripsiFoto,
    required this.lokasiFile,
    required this.namaAlbum,
    required this.deskripsiAlbum,
  });

  @override
  State<EditFoto> createState() => _EditFotoState();
}

class _EditFotoState extends State<EditFoto> {
  TextEditingController judulFoto = TextEditingController();
  TextEditingController deskripsiFoto = TextEditingController();

  File? fileFoto;

  Future pilihFoto() async {
    final foto = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (foto != null) {
      setState(() {
        fileFoto = File(foto.path);
      });
    }
  }

  Future editFoto(String judulFoto, deskripsiFoto, fotoId) async {
    var body = {
      'judulfoto': judulFoto,
      'deskripsifoto': deskripsiFoto,
      'fotoid': fotoId,
    };

    if (fileFoto != null) {
      final bytesFoto = await fileFoto!.readAsBytes();
      String base64Foto = base64Encode(bytesFoto);
      body['foto'] = base64Foto;
    }

    var response = await http.post(
      Uri.parse(urlEditFoto),
      body: body,
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
    judulFoto.text = widget.judulFoto;
    deskripsiFoto.text = widget.deskripsiFoto;
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
                              userId: widget.userId,
                              albumId: widget.albumId,
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
                  Container(
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
                              : widget.lokasiFile.isEmpty
                                  ? const SizedBox()
                                  : Image.memory(
                                      base64Decode(widget.lokasiFile),
                                      width: MediaQuery.sizeOf(context).width,
                                      fit: BoxFit.cover,
                                    ),
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
                        Bounce(
                          tilt: false,
                          onTap: () {
                            pilihFoto();
                          },
                          child: BlueButton(
                            width: MediaQuery.sizeOf(context).width * 0.8,
                            height: 50.0,
                            text: 'Ubah Foto',
                          ),
                        ),
                        const SizedBox(height: 10),
                        Bounce(
                          tilt: false,
                          onTap: () {
                            editFoto(
                              judulFoto.text,
                              deskripsiFoto.text,
                              widget.fotoId,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Simpan Berhasil',
                                  style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
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
