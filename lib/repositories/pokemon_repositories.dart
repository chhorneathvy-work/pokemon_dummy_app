mixin PokemonRepositories {
  static const String categoryList = """
    query {
      categoryListQuery {
        id
        name
        created_at
        updated_at
      }
    }
  """;

  static const String pokemonList = """
    query PokemonListQuery(
      \$categoryId: Int,
      \$page: Int,
      \$limit: Int,
      \$search: String
    ) {
      pokemonListQuery(
        categoryId: \$categoryId,
        page: \$page,
        limit: \$limit,
        search: \$search
      ) {
        id
        category_id
        category_name
        pokemon_name
        pokemon_description
        pokemon_image
      }
    }
  """;

  static const String pokemonDetail = """
    query PokemonDetailQuery(\$pokemonDetailQueryId: Int!) {
      pokemonDetailQuery(id: \$pokemonDetailQueryId) {
        id
        category_id
        category_name
        pokemon_name
        pokemon_description
        pokemon_image
      }
    }
  """;

  static const String createPokemon = """
mutation CreatePokemon(\$input: CreatePokemonInput!) {
  createPokemon(input: \$input) {
    id
    category_id
    category_name
    pokemon_name
    pokemon_description
    pokemon_image
  }
}
""";

  static const String updatePokemon = """
mutation UpdatePokemon(
  \$updatePokemonId: Int!,
  \$input: UpdatePokemonInput!
) {
  updatePokemon(id: \$updatePokemonId, input: \$input) {
    id
    category_id
    category_name
    pokemon_name
    pokemon_description
    pokemon_image
  }
}
""";

  static const String deletePokemon = """
mutation DeletePokemon(\$id: Int!) {
  deletePokemon(id: \$id)
}
""";

}
