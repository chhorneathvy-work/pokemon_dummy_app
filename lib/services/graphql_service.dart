import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:gql_dio_link/gql_dio_link.dart';
import 'dio_client.dart';

class GraphQLService {
  static const String baseUrl = "";

  static GraphQLClient client = GraphQLClient(
    link: DioLink(
      baseUrl,
      client: DioClient.dio,
    ),
    cache: GraphQLCache(),
  );

  static GraphQLClient authClient(String token) {
    DioClient.setToken(token);

    return GraphQLClient(
      link: DioLink(
        baseUrl,
        client: DioClient.dio,
      ),
      cache: GraphQLCache(),
    );
  }
}
