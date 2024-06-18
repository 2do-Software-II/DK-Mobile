// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hotel_app/utils/customer_class.dart';
import 'package:hotel_app/utils/habitacion_class.dart';
import 'package:hotel_app/utils/reserva_class.dart';

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
    mutation UpdateRoomStatus(\$id: ID!, \$status: String!) {
      updateRoom(id: \$id, updateRoomDto: {status: \$status}) {
        id
        status
      }
    }
  """;

  Future<void> updateRoomStatus(String roomId, String status) async {
    final MutationOptions options = MutationOptions(
      document: gql(updateRoomStatusMutation),
      variables: {
        'id': roomId,
        'status': status,
      },
    );

    final QueryResult result = await _client.mutate(options);

    if (result.hasException) {
      if (result.exception?.graphqlErrors != null) {
        for (var error in result.exception!.graphqlErrors) {
          print('GraphQL Error: ${error.message}');
        }
      }
      if (result.exception?.linkException != null) {
        print('Link Exception: ${result.exception!.linkException}');
      }
      throw Exception(result.exception.toString());
    }

    if (result.data != null) {
      final updatedRoom = result.data!['updateRoom'];
      print(
          'Room updated: ${updatedRoom['id']}, status: ${updatedRoom['status']}');
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

  Future<String> createCustomer(Customer customer, BuildContext context) async {
    const String mutation = r'''
      mutation MyMutation(
        $name: String!,
        $lastName: String!,
        $phone: String!,
        $ci: String!,
        $expedition: String!,
        $birthDate: String!,
        $nationality: String!,
        $gender: String!,
        $preference: String!,
        $user: String!,
        $address: String!
      ) {
        createCustomer(
          createCustomerDto: {
            name: $name,
            lastName: $lastName,
            phone: $phone,
            ci: $ci,
            expedition: $expedition,
            birthDate: $birthDate,
            nationality: $nationality,
            gender: $gender,
            preference: $preference,
            user: $user,
            address: $address
          }
        ) {
          id
        }
      }
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(mutation),
      variables: {
        'name': customer.name,
        'lastName': customer.lastName,
        'phone': customer.phone,
        'ci': customer.ci,
        'expedition': customer.expedition,
        'birthDate': customer.birthDate,
        'nationality': customer.nationality,
        'gender': customer.gender,
        'preference': customer.preference,
        'user': customer.id,
        'address': customer.address,
      },
    );

    final QueryResult result = await _client.mutate(options);

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }
    return result.data!['createCustomer']['id'];
  }

  Future<String?> fetchCustomerIdByUserId(String userId) async {
    const String query = r'''
      query MyQuery($id: String!) {
        getOneCustomer(id: $id) {
          user {
            id
          }
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

    if (result.data != null && result.data!['getOneCustomer'] != null) {
      return result.data!['getOneCustomer']['user']['id'];
    }

    return null;
  }

  Future<void> createBooking(
    String date,
    String time,
    String paymentMethod,
    String startDate,
    String endDate,
    String customer,
    String room,
    String status,
    double fullPayment,
  ) async {
    try {
      const String mutation = r'''
    mutation MyMutation(
      $date: String!,
      $time: String!,
      $paymentMethod: String!,
      $startDate: String!,
      $endDate: String!,
      $customer: String!,
      $room: String!,
      $status: String!,
      $fullPayment: Float!
    ) {
      createBooking(
        createBookingDto: {
          date: $date,
          time: $time,
          checkIn: "",
          checkOut: "",
          paymentMethod: $paymentMethod,
          startDate: $startDate,
          endDate: $endDate,
          customer: $customer,
          room: $room,
          status: $status,
          fullPayment: $fullPayment
        }
      ) {
        customer {
          id
        }
        date
        endDate
        paymentMethod
        room {
          id
        }
        startDate
        status
        time
        fullPayment
      }
    }
  ''';

      final MutationOptions options = MutationOptions(
        document: gql(mutation),
        variables: {
          'date': date,
          'time': time,
          'paymentMethod': paymentMethod,
          'startDate': startDate,
          'endDate': endDate,
          'customer': customer,
          'room': room,
          'status': status,
          'fullPayment': fullPayment,
        },
      );
      print(mutation);
      print(options);
      final QueryResult result = await _client.mutate(options);
      print(result);
    } catch (e) {
      print(e);
    }
  }

  static const String getAllBookingsByQuery = r'''
    query MyQuery($attr: String!, $value: String!) {
      getAllBookingsBy(attr: $attr, value: $value) {
        customer {
          id
        }
        checkIn
        checkOut
        date
        endDate
        fullPayment
        paymentMethod
        prePaid
        room {
          description
        }
        startDate
        status
        time
      }
    }
  ''';

  Future<List<Reserva>> getAllBookingsBy(String attribute, String value) async {
    print(attribute);
    print(value);
    final QueryOptions options = QueryOptions(
      document: gql(getAllBookingsByQuery),
      variables: {
        'attr': attribute,
        'value': value,
      },
    );

    final QueryResult result = await _client.query(options);

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final List<dynamic> data = result.data?['getAllBookingsBy'] ?? [];
    return data.map((booking) => Reserva.fromJson(booking)).toList();
  }
}
