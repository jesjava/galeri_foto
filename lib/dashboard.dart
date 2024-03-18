import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:galeri_foto/halaman_beranda/postingan.dart';
import 'package:galeri_foto/halaman_album/album.dart';
import 'package:galeri_foto/halaman_profil/profil.dart';

// ignore: must_be_immutable
class DashboardWidget extends StatefulWidget {
  String userId;
  DashboardWidget({
    super.key,
    required this.userId,
  });

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

List<String> icons = [
  'assets/icons/home_outlined.png',
  'assets/icons/home_filled.png',
  'assets/icons/album_outlined.png',
  'assets/icons/album_filled.png',
  'assets/icons/profile_outlined.png',
  'assets/icons/profile_filled.png',
];

List<bool> isIconTapped = [
  true,
  false,
  false,
];

List<bool> halamanAktif = [
  true,
  false,
  false,
];

renderIcon(String icon) {
  return Image.asset(
    icon,
    fit: BoxFit.contain,
    width: 23,
    height: 23,
  );
}

class _DashboardWidgetState extends State<DashboardWidget> {

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Color.fromRGBO(54, 76, 225, 1),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    isIconTapped[0] = true;
    isIconTapped[1] = false;
    isIconTapped[2] = false;
    halamanAktif[0] = true;
    halamanAktif[1] = false;
    halamanAktif[2] = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            Visibility(
              visible: halamanAktif[0],
              child: WidgetPostingan(
                userId: widget.userId,
              ),
            ),
            Visibility(
              visible: halamanAktif[1],
              child: WidgetAlbum(
                userId: widget.userId,
              ),
            ),
            Visibility(
              visible: halamanAktif[2],
              child: WidgetProfil(
                userId: widget.userId,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.sizeOf(context).width,
        height: 60,
        color: const Color.fromRGBO(54, 76, 225, 1),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Bounce(
                tilt: false,
                onTap: () {
                  setState(() {
                    // IKON
                    isIconTapped[0] = true;
                    isIconTapped[1] = false;
                    isIconTapped[2] = false;
                    // HALAMAN
                    halamanAktif[0] = true;
                    halamanAktif[1] = false;
                    halamanAktif[2] = false;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    renderIcon(isIconTapped[0] ? icons[1] : icons[0]),
                    Text(
                      'Beranda',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 15,
                        color: isIconTapped[0]
                            ? Colors.white
                            : Colors.white.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Bounce(
                tilt: false,
                onTap: () {
                  setState(() {
                    // IKON
                    isIconTapped[0] = false;
                    isIconTapped[1] = true;
                    isIconTapped[2] = false;
                    // HALAMAN
                    halamanAktif[0] = false;
                    halamanAktif[1] = true;
                    halamanAktif[2] = false;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    renderIcon(isIconTapped[1] ? icons[3] : icons[2]),
                    Text(
                      'Album',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 15,
                        color: isIconTapped[1]
                            ? Colors.white
                            : Colors.white.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Bounce(
                tilt: false,
                onTap: () {
                  setState(() {
                    // IKON
                    isIconTapped[0] = false;
                    isIconTapped[1] = false;
                    isIconTapped[2] = true;
                    // HALAMAN
                    halamanAktif[0] = false;
                    halamanAktif[1] = false;
                    halamanAktif[2] = true;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    renderIcon(isIconTapped[2] ? icons[5] : icons[4]),
                    Text(
                      'Profil',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 15,
                        color: isIconTapped[2]
                            ? Colors.white
                            : Colors.white.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
