import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class FetchPokemonList extends ProductEvent {
  final String? search;
  final int? categoryId;
  final int page;
  final int limit;
  final bool append;

  const FetchPokemonList({
    this.search,
    this.categoryId,
    this.page = 1,
    this.limit = 30,
    this.append = false,
  });

  @override
  List<Object?> get props => [search, categoryId, page, limit, append];
}

class CreatePokemon extends ProductEvent {
  final String pokemonName;
  final String pokemonImage;
  final String pokemonDescription;
  final String categoryName;

  const CreatePokemon({
    required this.pokemonName,
    required this.pokemonImage,
    required this.pokemonDescription,
    required this.categoryName,
  });

  @override
  List<Object?> get props => [pokemonName, pokemonImage, pokemonDescription, categoryName];
}

class UpdatePokemon extends ProductEvent {
  final int id;
  final String pokemonName;
  final String pokemonImage;
  final String pokemonDescription;
  final String categoryName;

  const UpdatePokemon({
    required this.id,
    required this.pokemonName,
    required this.pokemonImage,
    required this.pokemonDescription,
    required this.categoryName,
  });

  @override
  List<Object?> get props =>
      [id, pokemonName, pokemonImage, pokemonDescription, categoryName];
}

class DeletePokemon extends ProductEvent {
  final int id;

  const DeletePokemon(this.id);

  @override
  List<Object?> get props => [id];
}

