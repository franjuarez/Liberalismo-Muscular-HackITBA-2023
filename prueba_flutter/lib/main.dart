import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

Future<void> addPassword(String user, String domain, String username, String password) async {
  var url = Uri.parse('http://10.7.17.82:8000/$user/add_password');
  var response = await http.post(url, body: {
    'user': user,'domain': domain,'username': username, 'password': password});

  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
}

String user = 'Monke';
String domain = 'Microsoft';
String username = 'lemonke';
String password = 'tetas12';

// addPassword(user, domain, username, password);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter FastAPI Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Users'),
        ),
        body: FutureBuilder(
          future: http.get(Uri.parse('http://10.7.17.82:8000/users')),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //ACÁ ME AGARRO LA DATA DEL BACK
              var data = jsonDecode(snapshot.data?.body ?? '');
              //de acá para abajo hago boludeces con esa data

              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text((data[index]).toString()),
                    // title: Text(data[index]['name']),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
