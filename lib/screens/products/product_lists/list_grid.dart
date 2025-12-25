import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/products/products_bloc.dart';
import '../../../blocs/products/products_state.dart';
import '../../../constants/app_color.dart';
import '../../../widgets/product_card_widget.dart';

class ListGrid extends StatelessWidget {
  final int currentPage;
  final bool hasNextPage;
  final VoidCallback onNext;
  final VoidCallback onPrev;

  const ListGrid({
    super.key,
    required this.currentPage,
    required this.hasNextPage,
    required this.onNext,
    required this.onPrev,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state.isLoading && state.pokemon.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        final items = state.pokemon;

        if (items.isEmpty && currentPage == 1) {
          return const Center(child: Text("No Pokémon found"));
        }

        return Column(
          children: [
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: items.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.82,
                ),
                itemBuilder: (_, index) {
                  return PokemonCardWidget(data: items[index]);
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.chevron_left),
                        onPressed: currentPage > 1 ? onPrev : null,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.cardDark,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Text(
                          "$currentPage",
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.chevron_right),
                        onPressed: hasNextPage ? onNext : null,
                      ),
                    ],
                  ),

                  if (!hasNextPage)
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text(
                        "You’ve reached the end of the Pokémon list ✨",
                        style: TextStyle(
                          fontSize: 13,
                          color:
                          AppColors.textDark.withValues(alpha: 0.5),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

