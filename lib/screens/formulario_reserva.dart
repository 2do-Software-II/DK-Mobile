// ignore_for_file: library_private_types_in_public_api, unused_field, use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hotel_app/screens/payment.dart';
import 'package:hotel_app/theme/color.dart';
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
    _date = '${now.day}/${now.month}/${now.year}';
    _time = '${now.hour}:${now.minute}';

    // Obtener el customer_id desde SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? customerJson = prefs.getString('customer');

    if (customerJson != null) {
      Map<String, dynamic> customerMap = jsonDecode(customerJson);
      _customerId = customerMap['id'] ?? '';
    }

    _fullPayment = widget.habitacion.price;

    setState(() {});
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
    print("date: $_date,\n"
        "time: $_time,\n"
        "paymentMethod: $_paymentMethodController,\n"
        "startDate: $_startDateController,\n"
        "endDate: $_endDateController,\n"
        "customerId: $_customerId,\n"
        "status: $_statusController,\n");
    print(widget.habitacion.id);
    if (_formKey.currentState!.validate()) {
      await createBookiing(
          _date,
          _time,
          _paymentMethodController.text,
          _startDateController.text,
          _endDateController.text,
          _customerId,
          widget.habitacion.id,
          _statusController.text,
          _fullPayment);
      print("Reserva creada!");
      await Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => PaymentPage(
          amount: widget.habitacion.price,
          habitacion: widget.habitacion,
        ),
      ));
    } else {
      print("Error al validar el formulario");
    }
  }
}
