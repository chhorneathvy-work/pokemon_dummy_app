import 'package:graphql_flutter/graphql_flutter.dart';
import '../services/graphql_service.dart';
import '../models/category_res_model.dart';
import '../repositories/pokemon_repositories.dart';

class CategoryRepository {
  Future<List<CategoryListQuery>> getCategoryList() async {
    final result = await GraphQLService.client.query(
      QueryOptions(
        document: gql(PokemonRepositories.categoryList),
      ),
    );

    if (result.hasException) {
      throw result.exception!;
    }

    final res = CategoryListRes.fromJson(result.data!);

    return res.categories ?? [];
  }
}