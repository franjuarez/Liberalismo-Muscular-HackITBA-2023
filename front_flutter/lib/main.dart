import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String user = 'Monke';
String domain = 'Microsoft';
String username = 'lemonke';
String password = 'tetas12';

String domain1 = 'Gugul';
String username1 = 'monkesin';
String password1 = 'tetas13';

String user2 = 'Valen';
String domain2 = 'Gugul';
String username2 = 'monkesin';
String password2 = 'tetas13';

void main() {
  addPassword(user, domain, username, password);
  addPassword(user, domain1, username1, password1);
  addPassword(user2, domain2, username2, password2);
  runApp(const MyApp());
}

Future<void> addPassword(
    String user, String domain, String username, String password) async {
  var url = Uri.parse(
      'http://10.7.17.82:8000/add_password?user=$user&domain=$domain&username=$username&password=$password');
  var response = await http.post(url);

  //To check if the response is OK
  // print('Response status: ${response.statusCode}');
  // print('Response body: ${response.body}');
}

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
                itemCount: 1,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text((data).toString()),
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
