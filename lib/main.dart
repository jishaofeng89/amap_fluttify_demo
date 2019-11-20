import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

import 'map/map.screen.dart';

void main() async {
  AmapService.init('6a6b60a38543211fe2097ced874b3fdf');

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: const Text('AMaps examples')),
          // backgroundColor: Colors.grey.shade200,
          body: MapDemo(),
        ),
      ),
    );
  }
}
