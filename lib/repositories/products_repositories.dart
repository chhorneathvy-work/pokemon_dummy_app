import 'package:graphql_flutter/graphql_flutter.dart';
import '../models/product_res_model.dart';
import '../services/graphql_service.dart';
import '../repositories/pokemon_repositories.dart';

class ProductRepository {
  /// Fetch Pokémon list from the server.
  ///
  /// IMPORTANT:
  /// - Do NOT enforce a client-side page/limit unless you intentionally
  ///   want to override the server defaults.
  /// - Only pass variables that are provided (avoid sending `limit: null`).
  Future<List<PokemonListQuery>> getPokemonList({
    int? categoryId,
    int? page,
    int? limit,
    String? search,
  }) async {
    // debugPrint('Fetching Pokémon list page= $page limit= $limit search= $search');
    // Build variables map only with non-null entries
    final Map<String, dynamic> variables = {};
    if (categoryId != null) variables['categoryId'] = categoryId;
    if (page != null) variables['page'] = page;
    if (search != null && search.isNotEmpty) variables['search'] = search;

    final result = await GraphQLService.client.query(
      QueryOptions(
        document: gql(PokemonRepositories.pokemonList),
        variables: variables,
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    // GraphQL errors -> throw so callers can handle
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    // Map GraphQL response to wrapper model and return the list
    final res = PokemonListRes.fromJson(result.data!);
    return res.pokemon ?? [];
  }

  // Fetch Pokémon detail by id (unchanged)
  Future<PokemonListQuery> getPokemonDetail(int id) async {
    final result = await GraphQLService.client.query(
      QueryOptions(
        document: gql(PokemonRepositories.pokemonDetail),
        variables: {"pokemonDetailQueryId": id},
      ),
    );

    if (result.hasException) throw result.exception!;
    return PokemonListQuery.fromJson(result.data!['pokemonDetailQuery']);
  }

  Future<PokemonListQuery> createPokemon({
    required String pokemonName,
    required String pokemonImage,
    required String pokemonDescription,
    required String categoryName,
  }) async {
    final result = await GraphQLService.client.mutate(
      MutationOptions(
        document: gql(PokemonRepositories.createPokemon),
        variables: {
          "input": {
            "pokemon_name": pokemonName,
            "pokemon_image": pokemonImage,
            "pokemon_description": pokemonDescription,
            "category_name": categoryName,
          },
        },
      ),
    );

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    return PokemonListQuery.fromJson(result.data!['createPokemon']);
  }

  Future<PokemonListQuery> updatePokemon({
    required int id,
    required String pokemonName,
    required String pokemonImage,
    required String pokemonDescription,
    required String categoryName,
  }) async {
    final result = await GraphQLService.client.mutate(
      MutationOptions(
        document: gql(PokemonRepositories.updatePokemon),
        variables: {
          "updatePokemonId": id,
          "input": {
            "pokemon_name": pokemonName,
            "pokemon_image": pokemonImage,
            "pokemon_description": pokemonDescription,
            "category_name": categoryName,
          },
        },
      ),
    );

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    return PokemonListQuery.fromJson(result.data!['updatePokemon']);
  }

  Future<void> deletePokemon(int id) async {
    final result = await GraphQLService.client.mutate(
      MutationOptions(
        document: gql(PokemonRepositories.deletePokemon),
        variables: {"id": id},
      ),
    );

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }
  }
}
