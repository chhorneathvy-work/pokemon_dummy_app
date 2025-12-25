// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../blocs/products/products_bloc.dart';
// import '../../blocs/products/products_event.dart';
// import '../../blocs/products/products_state.dart';
// import 'update_product_screen.dart';
//
// class PokemonDetailScreen extends StatelessWidget {
//   final int pokemonId;
//
//   const PokemonDetailScreen({
//     super.key,
//     required this.pokemonId,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//
//     return BlocListener<ProductBloc, ProductState>(
//       listenWhen: (p, c) =>
//       p.deleteSuccess != c.deleteSuccess || p.error != c.error,
//       listener: (context, state) {
//         if (state.deleteSuccess) {
//           Navigator.pop(context);
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text("Pokémon deleted successfully ✨")),
//           );
//         }
//         if (state.error != null) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(state.error!)),
//           );
//         }
//       },
//       child: BlocBuilder<ProductBloc, ProductState>(
//         buildWhen: (prev, curr) => prev.pokemon != curr.pokemon,
//         builder: (context, state) {
//           final data = state.pokemon.firstWhere(
//                 (p) => p.id == pokemonId,
//             orElse: () => throw Exception("Pokémon not found"),
//           );
//
//           return Scaffold(
//             backgroundColor: Colors.grey.shade100,
//             body: SafeArea(
//               child: Column(
//                 children: [
//                   //  TOP BAR
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 12),
//                     child: Row(
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.arrow_back),
//                           onPressed: () => Navigator.pop(context),
//                         ),
//                         const Spacer(),
//
//                         PopupMenuButton<String>(
//                           color: Colors.white,
//                           elevation: 8,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(14),
//                           ),
//                           icon: Container(
//                             padding: const EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               color: Colors.grey.shade200,
//                               shape: BoxShape.circle,
//                             ),
//                             child: const Icon(Icons.more_horiz_rounded),
//                           ),
//                           onSelected: (value) {
//                             if (value == 'edit') {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (_) =>
//                                       UpdatePokemonScreen(data: data),
//                                 ),
//                               );
//                             }
//                             if (value == 'delete') {
//                               _confirmDelete(context, data.id!);
//                             }
//                           },
//                           itemBuilder: (_) =>
//                           [
//                             const PopupMenuItem(
//                               value: 'edit',
//                               child: Text("Edit"),
//                             ),
//                             const PopupMenuItem(
//                               value: 'delete',
//                               child: Text(
//                                 "Delete",
//                                 style: TextStyle(color: Colors.red),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//
//                   Hero(
//                     tag: "pokemon_${data.id}",
//                     child: SizedBox(
//                       height: 220,
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 24),
//                         child: Image.network(
//                           data.pokemonImage ?? "",
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   const SizedBox(height: 12),
//
//                   Expanded(
//                     child: Container(
//                       width: double.infinity,
//                       decoration: const BoxDecoration(
//                         color: Colors.white,
//                         borderRadius:
//                         BorderRadius.vertical(top: Radius.circular(28)),
//                       ),
//                       child: SingleChildScrollView(
//                         padding:
//                         const EdgeInsets.fromLTRB(20, 24, 20, 32),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               data.pokemonName ?? "",
//                               style: theme.textTheme.headlineSmall?.copyWith(
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(height: 10),
//                             Text(data.categoryName ?? ""),
//                             const SizedBox(height: 24),
//                             const Text(
//                               "Description",
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w700,
//                               ),
//                             ),
//                             const SizedBox(height: 10),
//                             Text(
//                               data.pokemonDescription ?? "",
//                               style: TextStyle(
//                                 fontSize: 15,
//                                 height: 1.6,
//                                 color: Colors.grey.shade800,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   void _confirmDelete(BuildContext context, int id) {
//     showDialog(
//       context: context,
//       builder: (dialogContext) =>
//           AlertDialog(
//             backgroundColor: Colors.white,
//             surfaceTintColor: Colors.white,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(18),
//             ),
//             elevation: 0,
//             contentPadding: const EdgeInsets.all(16),
//             title: const Text("Delete Pokémon"),
//             content: const Text("Are you sure?"),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(dialogContext).pop();
//                 },
//                 child: const Text(
//                   "Cancel",
//                   style: TextStyle(color: Colors.black),
//                 ),
//               ),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.red,
//                 ),
//                 onPressed: () {
//                   Navigator.of(dialogContext).pop();
//                   context.read<ProductBloc>().add(DeletePokemon(id));
//                 },
//                 child: const Text(
//                   "Delete",
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ],
//           ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/products/products_bloc.dart';
import '../../blocs/products/products_event.dart';
import '../../blocs/products/products_state.dart';
import '../../models/product_res_model.dart';
import 'update_product_screen.dart';

class PokemonDetailScreen extends StatelessWidget {
  final int pokemonId;

  const PokemonDetailScreen({
    super.key,
    required this.pokemonId,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<ProductBloc, ProductState>(
      listenWhen: (prev, curr) =>
      prev.deleteSuccess != curr.deleteSuccess ||
          prev.error != curr.error,
      listener: (context, state) {
        if (state.deleteSuccess) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Pokémon deleted successfully ✨"),
            ),
          );
        }

        if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error!)),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: SafeArea(
          child: BlocSelector<ProductBloc, ProductState, PokemonListQuery?>(
            selector: (state) => state.byId(pokemonId),
            builder: (context, data) {
              if (data == null) {
                return const Center(
                  child: Text("Pokémon not found"),
                );
              }

              return Column(
                children: [
                  // ================= TOP BAR =================
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const Spacer(),
                        PopupMenuButton<String>(
                          color: Colors.white,
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          icon: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.more_horiz_rounded),
                          ),
                          onSelected: (value) async {
                            if (value == 'edit') {
                              // final updated =
                              // await Navigator.push<PokemonListQuery>(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (_) =>
                              //         UpdatePokemonScreen(data: data),
                              //   ),
                              // );
                              final updated = await Navigator.push<PokemonListQuery>(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => UpdatePokemonScreen(data: data),
                                ),
                              );
                              // if (updated != null) {
                              //   context.read<ProductBloc>().add(
                              //     UpdatePokemon(
                              //       id: updated.id!,
                              //       pokemonName:
                              //       updated.pokemonName ?? "",
                              //       pokemonImage:
                              //       updated.pokemonImage ?? "",
                              //       pokemonDescription:
                              //       updated.pokemonDescription ?? "",
                              //       categoryName:
                              //       updated.categoryName ?? "",
                              //     ),
                              //   );
                              // }
                              if (!context.mounted) return;

                              if (updated != null) {
                                context.read<ProductBloc>().add(
                                  UpdatePokemon(
                                    id: updated.id!,
                                    pokemonName: updated.pokemonName!,
                                    pokemonImage: updated.pokemonImage!,
                                    pokemonDescription: updated.pokemonDescription!,
                                    categoryName: updated.categoryName!,
                                  ),
                                );
                              }

                            }

                            if (value == 'delete') {
                              _confirmDelete(context, data.id!);
                            }
                          },
                          itemBuilder: (_) => const [
                            PopupMenuItem(
                              value: 'edit',
                              child: Text("Edit"),
                            ),
                            PopupMenuItem(
                              value: 'delete',
                              child: Text(
                                "Delete",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // ================= IMAGE =================
                  Hero(
                    tag: "pokemon_${data.id}",
                    child: SizedBox(
                      height: 220,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Image.network(
                          data.pokemonImage ?? "",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // ================= CONTENT =================
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(28),
                        ),
                      ),
                      child: SingleChildScrollView(
                        padding:
                        const EdgeInsets.fromLTRB(20, 24, 20, 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.pokemonName ?? "",
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(data.categoryName ?? ""),
                            const SizedBox(height: 24),
                            const Text(
                              "Description",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              data.pokemonDescription ?? "",
                              style: TextStyle(
                                fontSize: 15,
                                height: 1.6,
                                color: Colors.grey.shade800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        elevation: 0,
        contentPadding: const EdgeInsets.all(16),
        title: const Text("Delete Pokémon"),
        content: const Text("Are you sure?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.black),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<ProductBloc>().add(DeletePokemon(id));
            },
            child: const Text(
              "Delete",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
