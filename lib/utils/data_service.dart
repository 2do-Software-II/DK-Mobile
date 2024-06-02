// lib/utils/data_service.dart

import 'package:graphql_flutter/graphql_flutter.dart';

class DataService {
  final GraphQLClient _client;

  DataService()
      : _client = GraphQLClient(
          link:
              HttpLink('https://jv-gateway-production.up.railway.app/graphql'),
          cache: GraphQLCache(),
        );

  Future<List<dynamic>> fetchAllRooms() async {
    const String query = r'''
      query MyQuery {
        getAllRooms {
          description
          nroRoom
          nroPersons
          type
          price
          size
          status
        }
      }
    ''';

    final QueryOptions options = QueryOptions(document: gql(query));
    final QueryResult result = await _client.query(options);

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    return result.data?['getAllRooms'] ?? [];
  }

  Future<List<dynamic>> fetchAllServices() async {
    const String query = r'''
      query MyQuery {
        getAllServices {
          description
          id
          name
        }
      }
    ''';

    final QueryOptions options = QueryOptions(document: gql(query));
    final QueryResult result = await _client.query(options);

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    return result.data?['getAllServices'] ?? [];
  }

  Future<List<dynamic>> fetchAllBookings() async {
    const String query = r'''
      query MyQuery {
        getAllBookings {
          date
          endDate
          fullPayment
          paymentMethod
          prePaid
          startDate
          status
          time
        }
      }
    ''';

    final QueryOptions options = QueryOptions(document: gql(query));
    final QueryResult result = await _client.query(options);

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    return result.data?['getAllBookings'] ?? [];
  }
}
