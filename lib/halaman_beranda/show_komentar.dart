import 'dart:convert';
import 'package:bounce/bounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:galeri_foto/api.dart';
import 'package:http/http.dart' as http;

class WidgetKomentar extends StatefulWidget {
  final String fotoId, userId;
  final bool showTotal;
  const WidgetKomentar({
    super.key,
    required this.fotoId,
    required this.userId,
    required this.showTotal,
  });

  @override
  State<WidgetKomentar> createState() => _WidgetKomentarState();
}

class _WidgetKomentarState extends State<WidgetKomentar> {
  List komentarData = [];
  TextEditingController komentarTEC = TextEditingController();

  Future tampilKomentar(String fotoId) async {
    var response = await http.post(
      Uri.parse(urlTampilKomentar),
      body: {
        'fotoid': fotoId,
      },
    );
    if (response.statusCode == 200) {
      setState(() {
        komentarData = json.decode(response.body);
      });
    } else {
      setState(() {
        komentarData = [];
      });
    }
  }

  Future insertKomentar(String fotoId, userId, isiKomentar) async {
    var response = await http.post(
      Uri.parse(urlInsertKomentar),
      body: {
        'fotoid': fotoId,
        'userid': userId,
        'isikomentar': isiKomentar,
      },
    );
    if (response.statusCode == 200) {
      //
    } else {
      //
    }
  }

  Future hapusKomentar(String komentarId, userId) async {
    var response = await http.post(
      Uri.parse(urlHapusKomentar),
      body: {
        'komentarid': komentarId,
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
    tampilKomentar(widget.fotoId);
  }

  @override
  Widget build(BuildContext context) {
    return widget.showTotal
        ? Row(
            children: [
              Text(
                '${komentarData.isNotEmpty ? komentarData.first['total_komentar'] : 0} Komentar',
                style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 17,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 50),
              GestureDetector(
                onTap: () {
                  tampilKomentar(widget.fotoId);
                },
                child: const Text(
                  'Refresh',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 17,
                    color: Color.fromRGBO(54, 76, 225, 1),
                  ),
                ),
              ),
            ],
          )
        : Container(
            height: MediaQuery.sizeOf(context).height * 0.8,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 85, 0, 70),
                  child: ListView.builder(
                    itemCount: komentarData.length,
                    itemBuilder: (context, index) {
                      var komentar = komentarData[index];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 10),
                              Text(
                                komentar['Username'],
                                style: const TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(flex: 1),
                              komentar['UserID'].toString() == widget.userId
                                  ? GestureDetector(
                                      onTap: () {
                                        hapusKomentar(
                                          komentar['KomentarID'].toString(),
                                          komentar['UserID'].toString(),
                                        );
                                        setState(() {
                                          komentarData.removeAt(index);
                                        });
                                      },
                                      child: const Icon(
                                        Icons.delete_rounded,
                                        color: Colors.black,
                                        size: 25,
                                      ),
                                    )
                                  : const SizedBox(),
                              const SizedBox(width: 10),
                            ],
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            margin: const EdgeInsets.fromLTRB(
                              10,
                              0,
                              50,
                              25,
                            ),
                            child: Text(
                              komentar['IsiKomentar'],
                              style: const TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: 75,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      const Spacer(flex: 1),
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.1,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      const Spacer(flex: 1),
                      const Text(
                        'Komentar',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(flex: 1),
                      Container(
                        width: MediaQuery.sizeOf(context).width,
                        height: 1,
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.sizeOf(context).width,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    height: 60,
                    color: const Color.fromRGBO(54, 76, 225, 1),
                    child: TextField(
                      controller: komentarTEC,
                      cursorColor: Colors.white,
                      cursorWidth: 1.5,
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 17,
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Masukkan Komentar',
                        hintStyle: const TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 17,
                          color: Colors.white,
                        ),
                        suffixIcon: Bounce(
                          tilt: false,
                          onTap: () {
                            insertKomentar(
                              widget.fotoId,
                              widget.userId,
                              komentarTEC.text,
                            );
                            Future.delayed(const Duration(seconds: 1), () {
                              komentarTEC.text = "";
                              tampilKomentar(widget.fotoId);
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(
                              10,
                              0,
                              0,
                              0,
                            ),
                            child: const Icon(
                              Icons.send_rounded,
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
