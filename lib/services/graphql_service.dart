import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:gql_dio_link/gql_dio_link.dart';
import 'dio_client.dart';

class GraphQLService {
  static const String baseUrl = "http://172.17.244.203:8080/pokemon-api/graphql";
  // static const String baseUrl = "http://192.168.100.48:8000/prokemon-api/graphql";
  // static const String baseUrl = 'http://localhost:8080/pokemon-api/graphql';


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
