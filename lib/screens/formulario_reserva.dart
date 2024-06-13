// ignore_for_file: library_private_types_in_public_api, unused_field, use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:hotel_app/screens/payment.dart';
import 'package:hotel_app/utils/data_service.dart';
import 'package:hotel_app/utils/habitacion_class.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingFormScreen extends StatefulWidget {
  final Habitacion habitacion;

  const BookingFormScreen({super.key, required this.habitacion});

  @override
  _BookingFormScreenState createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  final TextEditingController _paymentMethodController =
      TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final DataService _dataService = DataService();

  String _customerId = '';
  String _date = '';
  String _time = '';
  double _fullPayment = 0.0;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    // Obtener fecha y hora actuales
    DateTime now = DateTime.now();
    _date = '${now.year}-${now.month}-${now.day}';
    _time = '${now.hour}:${now.minute}';

    // Obtener el ID del cliente desde SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _customerId = prefs.getString('customer_id') ?? '';

    // Precio total es el precio de la habitación
    _fullPayment = widget.habitacion.price;

    setState(() {}); // Actualizar la interfaz después de obtener los datos
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Reserva'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              ListTile(
                title: Text('Tipo de Habitación: ${widget.habitacion.type}'),
                subtitle: Text(
                    'Precio por Noche: \$${widget.habitacion.price.toStringAsFixed(2)}'),
              ),
              TextFormField(
                controller: _paymentMethodController,
                decoration: const InputDecoration(labelText: 'Método de Pago'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Ingrese el método de pago';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _startDateController,
                decoration: const InputDecoration(labelText: 'Fecha de Inicio'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Ingrese la fecha de inicio';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _endDateController,
                decoration: const InputDecoration(labelText: 'Fecha de Fin'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Ingrese la fecha de fin';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _statusController,
                decoration: const InputDecoration(labelText: 'Estado'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Ingrese el estado';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await _navigateToPaymentPage();
                  }
                },
                child: const Text('Ir a Pago'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _navigateToPaymentPage() async {
    if (_formKey.currentState!.validate()) {
      try {
        String date = _date;
        String time = _time;
        String paymentMethod = _paymentMethodController.text;
        String startDate = _startDateController.text;
        String endDate = _endDateController.text;
        String customerId = _customerId;
        String status = _statusController.text;
        double fullPayment = _fullPayment;

        // Ejecutar la mutación para crear la reserva
        await _dataService.createBooking(
          date,
          time,
          paymentMethod,
          startDate,
          endDate,
          customerId,
          widget.habitacion.id,
          status,
          fullPayment,
        );

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => PaymentPage(
            amount: widget.habitacion.price,
            habitacion: widget.habitacion,
          ),
        ));
      } catch (e) {
        print(
            'Error al ejecutar la mutación y navegar a la pantalla de pago: $e');
        // Manejar el error según tus necesidades (mostrar mensaje al usuario, etc.)
      }
    }
  }
}
