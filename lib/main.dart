import 'package:flutter/material.dart';
import 'package:pokemon_store/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokémon Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Lato",
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}