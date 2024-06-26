// ignore_for_file: use_super_parameters, library_private_types_in_public_api, unused_field
import 'package:flutter/material.dart';
import 'package:hotel_app/utils/data_service.dart';
import 'package:hotel_app/utils/reserva_class.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String _customerId = '';

  @override
  void initState() {
    super.initState();
    _loadBookings();
  }

  Future<void> _loadBookings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _customerId = prefs.getString('customerId')!;
    _bookingsFuture = _dataService.getAllBookingsBy('customer', _customerId);
    print(_bookingsFuture);
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
            return const Center(
                child: Text(
                    'Visita la pagina para ver tus reservas con mas detalles.'));
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
