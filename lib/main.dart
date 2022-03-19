import 'package:flutter/material.dart';
import 'package:please/startpage.dart';

void main() => runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      title: '北洋杂烩',
      debugShowCheckedModeBanner: false,
      home: StartPage(),
    );
  }
}


