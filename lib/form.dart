import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:galeri_foto/dashboard.dart';
import 'package:galeri_foto/form_properties/app_logo.dart';
import 'package:galeri_foto/form_properties/field.dart';
import 'package:galeri_foto/form_properties/button.dart';
import 'package:galeri_foto/form_properties/bottom_card.dart';
import 'package:galeri_foto/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FormWidget extends StatefulWidget {
  const FormWidget({super.key});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  bool obscureText = true;
  bool isAnimating = false;
  bool isRegister = false;
  TextEditingController emailTEC = TextEditingController();
  TextEditingController passwordTEC = TextEditingController();
  TextEditingController usernameTEC = TextEditingController();
  bool isSplashed = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      Future.delayed(const Duration(milliseconds: 3000), () {
        setState(() {
          isSplashed = true;
        });
      });
    });
  }

  Future buatAkun(String username, password, email) async {
    var response = await http.post(
      Uri.parse(urlBuatAkun),
      body: {
        'Username': username,
        'Password': password,
        'Email': email,
      },
    );
    if (response.statusCode == 200) {
      //
    } else {
      //
    }
  }

  Future masukAkun(String password, email) async {
    var response = await http.post(
      Uri.parse(urlMasukAkun),
      body: jsonEncode({
        'password': password,
        'email': email,
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      if (responseBody['message'] == 'email atau password salah' ||
          responseBody['message'] == 'gagal masuk' ||
          responseBody['message'] == 'email dan password harus di isi') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Email Atau Password Salah',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return DashboardWidget(
                userId: responseBody['UserID'].toString(),
              );
            },
          ),
        );
      }
    } else {
      //
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(54, 76, 225, 1),
      body: SafeArea(
        child: Stack(
          children: [
            AppLogo(
              width: MediaQuery.sizeOf(context).width,
              height: isAnimating
                  ? MediaQuery.sizeOf(context).height * 0.8
                  : isSplashed
                      ? MediaQuery.sizeOf(context).height * 0.2
                      : MediaQuery.sizeOf(context).height * 0.8,
            ),
            isSplashed
                ? TweenAnimationBuilder(
                    tween: Tween<double>(
                      begin: MediaQuery.of(context).size.height,
                      end: isAnimating ? MediaQuery.of(context).size.height : 0,
                    ),
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.fastEaseInToSlowEaseOut,
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(0, value),
                        child: BottomCard(
                          width: MediaQuery.sizeOf(context).width,
                          height: MediaQuery.sizeOf(context).height * 0.7,
                          child: Column(
                            children: [
                              const SizedBox(height: 25),
                              Text(
                                isRegister ? 'Mari Mulai' : 'Selamat Datang',
                                style: const TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 30,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 25),
                              isRegister
                                  ? WidgetTextField(
                                      textEditingController: usernameTEC,
                                      obscureText: false,
                                      labelText: 'Nama Pengguna',
                                      suffixIcon: Icon(
                                        CupertinoIcons.person,
                                        color: Colors.black.withOpacity(0.5),
                                        size: 27,
                                      ),
                                    )
                                  : const SizedBox(),
                              isRegister
                                  ? const SizedBox(height: 25)
                                  : const SizedBox(),
                              WidgetTextField(
                                textEditingController: emailTEC,
                                obscureText: false,
                                labelText: 'Email',
                                suffixIcon: Icon(
                                  CupertinoIcons.mail,
                                  color: Colors.black.withOpacity(0.5),
                                  size: 27,
                                ),
                              ),
                              const SizedBox(height: 25),
                              WidgetTextField(
                                textEditingController: passwordTEC,
                                obscureText: obscureText,
                                labelText: 'Password',
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      obscureText = !obscureText;
                                    });
                                  },
                                  child: Icon(
                                    obscureText
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: Colors.black.withOpacity(0.5),
                                    size: 30,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 25),
                              isRegister
                                  ? GestureDetector(
                                      onTap: () {
                                        buatAkun(
                                          usernameTEC.text,
                                          passwordTEC.text,
                                          emailTEC.text,
                                        );
                                        setState(() {
                                          isAnimating = true;
                                          Future.delayed(
                                              const Duration(
                                                milliseconds: 1000,
                                              ), () {
                                            setState(() {
                                              // RESET TEXT
                                              emailTEC.text = '';
                                              passwordTEC.text = '';
                                              usernameTEC.text = '';
                                              // REVERSE VALUE
                                              obscureText = true;
                                              isAnimating = false;
                                              isRegister = !isRegister;
                                            });
                                          });
                                        });
                                      },
                                      child: WidgetButton(
                                        width: MediaQuery.sizeOf(context).width,
                                        buttonText: 'Buat Akun',
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        masukAkun(
                                          passwordTEC.text,
                                          emailTEC.text,
                                        );
                                      },
                                      child: WidgetButton(
                                        width: MediaQuery.sizeOf(context).width,
                                        buttonText: 'Masuk',
                                      ),
                                    ),
                              isRegister
                                  ? const SizedBox()
                                  : const SizedBox(height: 25),
                              isRegister
                                  ? const SizedBox()
                                  : GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return DashboardWidget(
                                                userId: '2',
                                              );
                                            },
                                          ),
                                        );
                                      },
                                      child: WidgetButton(
                                        width: MediaQuery.sizeOf(context).width,
                                        buttonText: 'Masuk sebagai tamu',
                                      ),
                                    ),
                              const Spacer(flex: 1),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    isRegister
                                        ? 'Sudah punya akun? '
                                        : 'Tidak punya akun? ',
                                    style: const TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: 17,
                                      color: Colors.black,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isAnimating = true;
                                        Future.delayed(
                                            const Duration(milliseconds: 1000),
                                            () {
                                          setState(() {
                                            // RESET TEXT
                                            emailTEC.text = '';
                                            passwordTEC.text = '';
                                            usernameTEC.text = '';
                                            // REVERSE VALUE
                                            obscureText = true;
                                            isAnimating = false;
                                            isRegister = !isRegister;
                                          });
                                        });
                                      });
                                    },
                                    child: Text(
                                      isRegister ? 'Masuk' : 'Buat Akun',
                                      style: const TextStyle(
                                        fontFamily: 'Nunito',
                                        fontSize: 17,
                                        color: Colors.black,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 25),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
