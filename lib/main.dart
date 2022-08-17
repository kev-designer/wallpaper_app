import 'package:flutter/material.dart';
import 'package:wallpaper_app/widgets/colors.dart';

import 'views/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pexels App',
      theme: ThemeData(
        scaffoldBackgroundColor: ColorData.black,
      ),
      home: const HomePage(),
    );
  }
}
