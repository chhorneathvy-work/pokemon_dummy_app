import 'package:flutter/material.dart';
import 'package:pokemon_store/screens/products/product_feature_shell.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ProductFeatureShell(),
    );
  }
}
