import 'package:flutter/material.dart';
import 'package:galeri_foto/halaman_beranda/like_button.dart';
import 'package:galeri_foto/halaman_beranda/show_komentar.dart';
import 'package:galeri_foto/halaman_beranda/readmore.dart';
import 'package:galeri_foto/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: must_be_immutable
class WidgetPostingan extends StatefulWidget {
  String userId;
  WidgetPostingan({
    super.key,
    required this.userId,
  });

  @override
  State<WidgetPostingan> createState() => _WidgetPostinganState();
}

class _WidgetPostinganState extends State<WidgetPostingan> {
  bool isLiked = false;
  TextEditingController komentarTEC = TextEditingController();
  bool isKomentarFocused = false;

  List<dynamic> postinganData = [];

  Future tampilPostingan(String userId) async {
    var response = await http.post(
      Uri.parse(urlPostingan),
      body: {
        'userid': userId,
      },
    );
    if (response.statusCode == 200) {
      setState(() {
        postinganData = json.decode(response.body);
      });
    } else {
      //
    }
  }

  @override
  void initState() {
    super.initState();
    tampilPostingan(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetPostingan = [];
    for (var item in postinganData) {
      widgetPostingan.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Row(
              children: [
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    setState(() {});
                  },
                  child: Text(
                    item['Username'],
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 23,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 10),
                Text(
                  item['JudulFoto'],
                  style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 17,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: item['LokasiFile'] == null
                  ? const SizedBox()
                  : Image.memory(
                      base64Decode(item['LokasiFile']),
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const SizedBox(width: 10),
                LikeButton(
                  fotoId: item['FotoID'].toString(),
                  userId: widget.userId,
                  liked: item['isLiked'] == 1,
                  onPressLike: () {},
                  totalLikes: item['total_like'],
                ),
                const SizedBox(width: 50),
                Column(
                  children: [
                    WidgetKomentar(
                      fotoId: item['FotoID'].toString(),
                      userId: widget.userId,
                      showTotal: true,
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return WidgetKomentar(
                              fotoId: item['FotoID'].toString(),
                              userId: widget.userId,
                              showTotal: false,
                            );
                          },
                        );
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/icons/comment_outlined.png',
                            width: 27,
                            height: 27,
                          ),
                          const Text(
                            'Komentar',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: ReadMoreText(
                item['DeskripsiFoto'],
                style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 17,
                  color: Colors.black,
                ),
                colorClickableText: const Color.fromRGBO(54, 76, 225, 1),
                trimLines: 2,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'Lihat Selengkapnya',
                trimExpandedText: ' Tutup Selengkapnya',
                moreStyle: const TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 17,
                  color: Color.fromRGBO(54, 76, 225, 1),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                'Diposting pada ${item['TanggalUnggah']}',
                style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 17,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      );
    }

    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgetPostingan,
      ),
    );
  }
}
