import 'dart:convert';
import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:galeri_foto/halaman_album/buat_album.dart';
import 'package:galeri_foto/halaman_album/lihat_album.dart';
import 'package:galeri_foto/api.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class WidgetAlbum extends StatefulWidget {
  String userId;
  WidgetAlbum({
    super.key,
    required this.userId,
  });

  @override
  State<WidgetAlbum> createState() => _WidgetAlbumState();
}

class _WidgetAlbumState extends State<WidgetAlbum> {
  List<dynamic> album = [];

  Future tampilAlbum(String userId) async {
    var response = await http.post(
      Uri.parse(urlTampilAlbum),
      body: {
        'UserID': userId,
      },
    );
    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          album = json.decode(response.body);
        });
      }
    } else {
      //
    }
  }

  Future hapusAlbum(String albumId) async {
    var response = await http.post(
      Uri.parse(urlHapusAlbum),
      body: {
        'albumid': albumId,
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
    tampilAlbum(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.userId == '2'
              ? Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height,
                  alignment: Alignment.center,
                  child: const Text(
                    'Tamu tidak dapat menambah album',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                )
              : Bounce(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return BuatAlbum(
                          userId: widget.userId,
                        );
                      },
                    ));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 200,
                    height: 50,
                    margin: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(54, 76, 225, 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text(
                      'Buat Album',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: album.length,
            itemBuilder: (context, index) {
              var item = album[index];
              return Container(
                width: MediaQuery.sizeOf(context).width,
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                margin: const EdgeInsets.fromLTRB(10, 25, 10, 0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(
                      color: Color.fromRGBO(54, 76, 225, 1),
                      width: 1,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['NamaAlbum'],
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Dibuat pada ${item['TanggalDibuat']}',
                          style: const TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                        const Spacer(flex: 1),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return LihatAlbum(
                                    albumId: item['AlbumID'],
                                    userId: widget.userId,
                                    namaAlbum: item['NamaAlbum'],
                                    deskripsiAlbum: item['Deskripsi'],
                                  );
                                },
                              ),
                            );
                          },
                          child: const Text(
                            'Lihat',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 20,
                              color: Color.fromRGBO(54, 76, 225, 1),
                            ),
                          ),
                        ),
                        const SizedBox(width: 25),
                        GestureDetector(
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
                                  hapusAlbum(item['AlbumID'].toString());
                                  setState(() {
                                    album.removeAt(index);
                                  });
                                },
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBarHapus);
                          },
                          child: const Text(
                            'Hapus',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 20,
                              color: Color.fromRGBO(255, 8, 8, 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
