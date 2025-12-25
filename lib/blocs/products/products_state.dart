// import 'package:equatable/equatable.dart';
// import '../../models/product_res_model.dart';
//
// class ProductState extends Equatable {
//   final bool isLoading;
//   final bool isCreating;
//   final bool createSuccess;
//   final bool updateSuccess;
//   final bool isDeleting;
//   final bool deleteSuccess;
//
//
//   final List<PokemonListQuery> pokemon;
//   final String? error;
//   final int page;
//   final bool hasMore;
//   final int lastFetchCount;
//   final PokemonListQuery? updatedPokemon;
//
//   const ProductState({
//     this.isLoading = false,
//     this.isCreating = false,
//     this.isDeleting = false,
//     this.createSuccess = false,
//     this.pokemon = const [],
//     this.error,
//     this.page = 1,
//     this.hasMore = true,
//     this.lastFetchCount = 0,
//     this.updateSuccess = false,
//     this.deleteSuccess = false,
//     this.updatedPokemon,
//   });
//
//   ProductState copyWith({
//     bool? isLoading,
//     bool? isCreating,
//     bool? isDeleting,
//     bool? createSuccess,
//     List<PokemonListQuery>? pokemon,
//     PokemonListQuery? updatedPokemon,
//     String? error,
//     int? page,
//     bool? hasMore,
//     int? lastFetchCount,
//     bool? updateSuccess,
//     bool? deleteSuccess,
//   }) {
//     return ProductState(
//       isLoading: isLoading ?? this.isLoading,
//       isCreating: isCreating ?? this.isCreating,
//       isDeleting: isDeleting ?? this.isDeleting,
//       createSuccess: createSuccess ?? this.createSuccess,
//       updatedPokemon: updatedPokemon,
//       pokemon: pokemon ?? this.pokemon,
//       error: error,
//       page: page ?? this.page,
//       hasMore: hasMore ?? this.hasMore,
//       lastFetchCount: lastFetchCount ?? this.lastFetchCount,
//       updateSuccess: updateSuccess ?? this.updateSuccess,
//       deleteSuccess: deleteSuccess ?? this.deleteSuccess,
//     );
//   }
//
//   @override
//   List<Object?> get props => [isLoading, isCreating, isDeleting,
//     createSuccess, updateSuccess, deleteSuccess, updatedPokemon,
//     pokemon, error, page, hasMore, lastFetchCount];
//
// }

import 'package:equatable/equatable.dart';
import '../../models/product_res_model.dart';

class ProductState extends Equatable {
  final bool isLoading;
  final bool isCreating;
  final bool isDeleting;

  final List<PokemonListQuery> pokemon;
  final String? error;

  final int page;
  final bool hasMore;
  final int lastFetchCount;

  // ⚠️ Still here, but no longer USED by update logic
  final bool createSuccess;
  final bool updateSuccess;
  final bool deleteSuccess;
  final PokemonListQuery? updatedPokemon;

  const ProductState({
    this.isLoading = false,
    this.isCreating = false,
    this.isDeleting = false,
    this.createSuccess = false,
    this.updateSuccess = false,
    this.deleteSuccess = false,
    this.updatedPokemon,
    this.pokemon = const [],
    this.error,
    this.page = 1,
    this.hasMore = true,
    this.lastFetchCount = 0,
  });

  ProductState copyWith({
    bool? isLoading,
    bool? isCreating,
    bool? isDeleting,
    bool? createSuccess,
    bool? updateSuccess,
    bool? deleteSuccess,
    PokemonListQuery? updatedPokemon,
    List<PokemonListQuery>? pokemon,
    String? error,
    int? page,
    bool? hasMore,
    int? lastFetchCount,
  }) {
    return ProductState(
      isLoading: isLoading ?? this.isLoading,
      isCreating: isCreating ?? this.isCreating,
      isDeleting: isDeleting ?? this.isDeleting,
      createSuccess: createSuccess ?? this.createSuccess,
      updateSuccess: updateSuccess ?? this.updateSuccess,
      deleteSuccess: deleteSuccess ?? this.deleteSuccess,
      updatedPokemon: updatedPokemon,
      pokemon: pokemon ?? this.pokemon,
      error: error,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      lastFetchCount: lastFetchCount ?? this.lastFetchCount,
    );
  }
  PokemonListQuery? byId(int id) {
    for (final p in pokemon) {
      if (p.id == id) return p;
    }
    return null;
  }

  @override
  List<Object?> get props => [
    isLoading, isCreating, isDeleting,
    createSuccess, updateSuccess, deleteSuccess, updatedPokemon,
    pokemon, error, page, hasMore, lastFetchCount,
  ];
}
