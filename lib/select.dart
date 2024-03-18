import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:galeri_foto/api.dart';
import 'dart:convert';

class WidgetSelect extends StatefulWidget {
  const WidgetSelect({super.key});

  @override
  State<WidgetSelect> createState() => _WidgetSelectState();
}

class _WidgetSelectState extends State<WidgetSelect> {
  Future fetchUsers() async {
    var result = await http.get(Uri.parse(urlMasukAkun));
    return json.decode(result.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetchUsers(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, int index) {
                return SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(snapshot.data[index]['UserID']),
                      Text(snapshot.data[index]['Username']),
                      Text(snapshot.data[index]['Password']),
                      Text(snapshot.data[index]['Email']),
                      Text(snapshot.data[index]['NamaLengkap']),
                      Text(snapshot.data[index]['Alamat']),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          } else {
            return Text('Loading');
          }
        },
      ),
    );
  }
}
