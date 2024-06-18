// ignore_for_file: use_super_parameters, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:hotel_app/utils/data_service.dart';
import 'package:hotel_app/utils/reserva_class.dart';

class MyBookingsScreen extends StatefulWidget {
  final String customerId;

  const MyBookingsScreen({Key? key, required this.customerId})
      : super(key: key);

  @override
  _MyBookingsScreenState createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  final DataService _dataService = DataService();
  late Future<List<Reserva>> _bookingsFuture;

  @override
  void initState() {
    super.initState();
    _loadBookings();
  }

  Future<void> _loadBookings() async {
    _bookingsFuture =
        _dataService.getAllBookingsBy('customer', widget.customerId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Reservas'),
      ),
      body: FutureBuilder<List<Reserva>>(
        future: _bookingsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No se encontraron reservas.'));
          } else {
            List<Reserva> bookings = snapshot.data!;
            return ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                Reserva reserva = bookings[index];
                return ListTile(
                  title: Text('Habitación: ${reserva.roomType}'),
                  subtitle: Text('Estado: ${reserva.status}'),
                  trailing: Text('Descripcion: ${reserva.roomDescription}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
