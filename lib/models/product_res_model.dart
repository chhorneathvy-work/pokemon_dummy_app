class PokemonListRes {
  List<PokemonListQuery>? pokemon;

  PokemonListRes({this.pokemon});

  factory PokemonListRes.fromJson(Map<String, dynamic> json) {
    return PokemonListRes(
      pokemon: json['pokemonListQuery'] != null
          ? List<PokemonListQuery>.from(
        json['pokemonListQuery'].map(
              (x) => PokemonListQuery.fromJson(x),
        ),
      )
          : [],
    );
  }
}
class PokemonListQuery {
  int? id;
  int? categoryId;
  String? categoryName;
  String? pokemonName;
  String? pokemonDescription;
  String? pokemonImage;

  PokemonListQuery({
    this.id,
    this.categoryId,
    this.categoryName,
    this.pokemonName,
    this.pokemonDescription,
    this.pokemonImage,
  });

  factory PokemonListQuery.fromJson(Map<String, dynamic> json) {
    return PokemonListQuery(
      id: json['id'],
      categoryId: json['category_id'],
      categoryName: json['category_name'],
      pokemonName: json['pokemon_name'],
      pokemonDescription: json['pokemon_description'],
      pokemonImage: json['pokemon_image'],
    );
  }

  PokemonListQuery copyWith({
    int? id,
    int? categoryId,
    String? categoryName,
    String? pokemonName,
    String? pokemonDescription,
    String? pokemonImage,
  }) {
    return PokemonListQuery(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      pokemonName: pokemonName ?? this.pokemonName,
      pokemonDescription:
      pokemonDescription ?? this.pokemonDescription,
      pokemonImage: pokemonImage ?? this.pokemonImage,
    );
  }
}



