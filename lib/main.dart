import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'views/Home/home.dart';

import 'package:http/http.dart' as http;

void main() {
  test();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

void test() async {
  String url = "https://srroky.pythonanywhere.com/";
  var response = await http.get(Uri.parse(url));
  print(response.body);
}
