import 'package:flutter/material.dart';
import 'package:objave_app/screens/home_screen.dart';

void main() {
  runApp(const ObjaveApp());
}

class ObjaveApp extends StatelessWidget {
  const ObjaveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Objave',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
