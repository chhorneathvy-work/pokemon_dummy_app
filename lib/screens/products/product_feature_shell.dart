import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_store/screens/products/product_lists/product_list_screen.dart';

import '../../blocs/category/category_bloc.dart';
import '../../blocs/category/category_event.dart';
import '../../blocs/products/products_bloc.dart';
import '../../blocs/products/products_event.dart';

class ProductFeatureShell extends StatelessWidget {
  const ProductFeatureShell({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CategoryBloc()..add(const FetchCategoryList()),
        ),
        BlocProvider(
          create: (_) => ProductBloc()..add(const FetchPokemonList()),
        ),
      ],
      child: PokemonListScreen(title: 'Pokemon'),
    );
  }
}
