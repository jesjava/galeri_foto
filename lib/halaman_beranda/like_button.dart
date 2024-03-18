import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:galeri_foto/api.dart';

// ignore: must_be_immutable
class LikeButton extends StatefulWidget {
  String fotoId, userId;
  bool liked;
  VoidCallback onPressLike;
  int totalLikes;

  LikeButton({
    super.key,
    required this.fotoId,
    required this.userId,
    required this.liked,
    required this.onPressLike,
    required this.totalLikes,
  });

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  late bool isLiked;

  Future insertLike(String fotoId, userId) async {
    var response = await http.post(
      Uri.parse(urlInsertLike),
      body: {
        'fotoid': fotoId,
        'userid': userId,
      },
    );
    if (response.statusCode == 200) {
      //
    } else {
      //
    }
  }

  Future deleteLike(String fotoId, userId) async {
    var response = await http.post(
      Uri.parse(urlDeleteLike),
      body: {
        'fotoid': fotoId,
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
    isLiked = widget.liked;
  }

  void pencetLike() {
    isLiked
        ? deleteLike(widget.fotoId, widget.userId)
        : insertLike(widget.fotoId, widget.userId);
    setState(() {
      isLiked ? widget.totalLikes-- : widget.totalLikes++;
      isLiked = !isLiked;
    });
    widget.onPressLike();
  }

  @override
  Widget build(BuildContext context) {
    return Bounce(
      tilt: false,
      onTap: () {
        pencetLike();
      },
      child: Column(
        children: [
          Text(
            '${widget.totalLikes} Suka',
            style: const TextStyle(
              fontFamily: 'Nunito',
              fontSize: 17,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          Image.asset(
            isLiked
                ? 'assets/icons/like_filled.png'
                : 'assets/icons/like_outlined.png',
            width: 27,
            height: 27,
          ),
          const Text(
            'Suka',
            style: TextStyle(
              fontFamily: 'Nunito',
              color: Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
