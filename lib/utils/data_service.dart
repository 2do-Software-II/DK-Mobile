import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hotel_app/utils/habitacion_class.dart';
import 'package:hotel_app/utils/reserva_class.dart'; // Importa la clase Reserva

class DataService {
  final GraphQLClient _client;

  DataService()
      : _client = GraphQLClient(
          link:
              HttpLink('https://jv-gateway-production.up.railway.app/graphql'),
          cache: GraphQLCache(),
        );

  Future<List<Habitacion>> fetchAllRooms() async {
    const String query = r'''
      query MyQuery {
        getAllRooms {
          nroRoom
          id
          description
          nroPersons
          nroBeds
          price
          size
          status
          type
          view
          resources {
            url
          }
        }
      }
    ''';

    final QueryOptions options = QueryOptions(document: gql(query));
    final QueryResult result = await _client.query(options);

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final List<dynamic> data = result.data?['getAllRooms'] ?? [];
    return data.map((room) => Habitacion.fromJson(room)).toList();
  }

  Future<List<Habitacion>> fetchAllRoomsRecommended(String userId) async {
    const String query = r'''
      query MyQuery($id: String!) {
        getAllRoomsRecommended(id: $id) {
          description
          id
          nroBeds
          nroPersons
          nroRoom
          price
          resources {
            url
          }
          size
          status
          type
          view
        }
      }
    ''';

    final QueryOptions options = QueryOptions(
      document: gql(query),
      variables: {'id': userId},
    );

    final QueryResult result = await _client.query(options);

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final List<dynamic> data = result.data?['getAllRoomsRecommended'] ?? [];
    return data.map((room) => Habitacion.fromJson(room)).toList();
  }

  static const String updateRoomStatusMutation = """
    mutation MyMutation(\$id: ID!) {
      updateRoom(id: \$id, updateRoomDto: {status: "Ocupado"}) {
        id
        status
      }
    }
  """;

  Future<void> updateRoomStatus(String roomId) async {
    final MutationOptions options = MutationOptions(
      document: gql(updateRoomStatusMutation),
      variables: {
        'id': roomId,
      },
    );

    final QueryResult result = await _client.mutate(options);

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }
  }

  Future<List<Reserva>> fetchAllBookings(String userId) async {
    const String query = r'''
      query MyQuery($id: String!) {
        getAllBookingsBy(attr: "id", value: $id) {
          customer {
            id
          }
          status
          room {
            type
            description
          }
          startDate
          endDate
        }
      }
    ''';

    final QueryOptions options = QueryOptions(
      document: gql(query),
      variables: {'id': userId},
    );

    final QueryResult result = await _client.query(options);

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final List<dynamic> data = result.data?['getAllBookingsBy'] ?? [];
    return data.map((booking) => Reserva.fromJson(booking)).toList();
  }
}
