import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_store/constants/app_color.dart';

import '../blocs/products/products_bloc.dart';
import '../blocs/category/category_bloc.dart';
import '../screens/products/create_product_screen.dart';

class CreateFabWidget extends StatelessWidget {
  const CreateFabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColors.cardDark,
      elevation: 6,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: context.read<ProductBloc>(),
                ),
                BlocProvider.value(
                  value: context.read<CategoryBloc>(),
                ),
              ],
              child: const CreatePokemonScreen(),
            ),
          ),
        );
      },
      child: const Icon(Icons.add, color: AppColors.textDark),
    );
  }
}
