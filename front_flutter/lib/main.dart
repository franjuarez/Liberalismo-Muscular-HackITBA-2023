import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() { 
  runApp(const MyApp());
}

// Future<void> addPassword(
//     String user, String domain, String username, String password) async {
//   var url = Uri.parse(
//       'http://10.7.17.82:8000/add_password?user=$user&domain=$domain&username=$username&password=$password');
//   var response = await http.post(url);

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
