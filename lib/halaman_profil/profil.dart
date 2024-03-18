import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:bounce/bounce.dart';
import 'package:galeri_foto/dashboard.dart';
import 'package:galeri_foto/form.dart';
import 'package:galeri_foto/halaman_profil/textfield.dart';
import 'package:http/http.dart' as http;
import 'package:galeri_foto/api.dart';

class WidgetProfil extends StatefulWidget {
  final String userId;
  const WidgetProfil({
    super.key,
    required this.userId,
  });

  @override
  State<WidgetProfil> createState() => _WidgetProfilState();
}

class _WidgetProfilState extends State<WidgetProfil> {
  TextEditingController usernameTEC = TextEditingController();
  TextEditingController namalengkapTEC = TextEditingController();
  TextEditingController alamatTEC = TextEditingController();

  Future editProfil(String userId, username, namaLengkap, alamat) async {
    var response = await http.post(
      Uri.parse(urlEditProfil),
      body: {
        'Username': username,
        'NamaLengkap': namaLengkap,
        'Alamat': alamat,
        'UserID': userId,
      },
    );
    if (response.statusCode == 200) {
      //
    } else {
      //
    }
  }

  String username = "", namaLengkap = "", alamat = "";

  Future tampilProfil(String userId) async {
    var response = await http.post(
      Uri.parse(urlTampilProfil),
      body: {
        'UserID': userId,
      },
    );
    final responseBody = json.decode(response.body);
    if (response.statusCode == 200) {
      //
      setState(() {
        username = responseBody['Username'];
        namaLengkap = responseBody['NamaLengkap'];
        alamat = responseBody['Alamat'];
      });
    } else {
      //
    }
  }

  Future hapusAkun(String userId) async {
    var response = await http.post(
      Uri.parse(urlHapusAkun),
      body: {
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
    tampilProfil(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height - 60,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(flex: 1),
          Image.asset(
            'assets/icons/profile_filled.png',
            color: Colors.black,
          ),
          Text(
            username,
            style: const TextStyle(
              fontFamily: 'Nunito',
              fontSize: 30,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          widget.userId == '2'
              ? const SizedBox()
              : Text(
                  namaLengkap,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 23,
                    color: Colors.black,
                  ),
                ),
          widget.userId == '2'
              ? const SizedBox()
              : Text(
                  alamat,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 23,
                    color: Colors.black,
                  ),
                ),
          widget.userId == '2' ? const SizedBox() : const Spacer(flex: 1),
          widget.userId == '2'
              ? const SizedBox()
              : Bounce(
                  tilt: false,
                  onTap: () {
                    setState(() {
                      usernameTEC.text = username;
                      namalengkapTEC.text = namaLengkap;
                      alamatTEC.text = alamat;
                    });
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return Container(
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
                              Column(
                                children: [
                                  const SizedBox(height: 100),
                                  widgetTextField(
                                    usernameTEC,
                                    'Username',
                                  ),
                                  const Spacer(flex: 1),
                                  widgetTextField(
                                    namalengkapTEC,
                                    'Nama Lengkap',
                                  ),
                                  const Spacer(flex: 1),
                                  widgetTextField(
                                    alamatTEC,
                                    'Alamat',
                                  ),
                                  const Spacer(flex: 1),
                                  Bounce(
                                    onTap: () {
                                      editProfil(
                                        widget.userId,
                                        usernameTEC.text,
                                        namalengkapTEC.text,
                                        alamatTEC.text,
                                      );
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
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: MediaQuery.sizeOf(context).width *
                                          0.9,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            54, 76, 225, 1),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: const Text(
                                        'Simpan',
                                        style: TextStyle(
                                          fontFamily: 'Nunito',
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 25),
                                ],
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
                                      width: MediaQuery.sizeOf(context).width *
                                          0.1,
                                      height: 5,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    const Spacer(flex: 1),
                                    const Text(
                                      'Edit Profil',
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
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(54, 76, 225, 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text(
                      'Edit Profil',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Bounce(
                tilt: false,
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const FormWidget();
                      },
                    ),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(54, 76, 225, 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Text(
                    'Keluar',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              widget.userId == '2'
                  ? const SizedBox()
                  : const SizedBox(width: 25),
              widget.userId == '2'
                  ? const SizedBox()
                  : Bounce(
                      tilt: false,
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
                              hapusAkun(widget.userId.toString());
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const FormWidget();
                                  },
                                ),
                              );
                            },
                          ),
                        );
                        ScaffoldMessenger.of(context)
                            .showSnackBar(snackBarHapus);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 175,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(255, 8, 8, 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Text(
                          'Hapus Akun',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
            ],
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
