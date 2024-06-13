// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:hotel_app/screens/room.dart';
import 'package:hotel_app/utils/data_service.dart';
import 'package:hotel_app/utils/habitacion_class.dart';

class PaymentPage extends StatelessWidget {
  final double amount;
  final Habitacion habitacion;
  final DataService dataService = DataService();

  PaymentPage({super.key, required this.amount, required this.habitacion});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Metodo de pago'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Total a pagar: \$${amount.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Image.asset(
              'assets/images/Logo-PayPal.webp',
              height: 100,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF003087),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () async {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => PaypalCheckoutView(
                    sandboxMode: true,
                    clientId:
                        "Adsv3e3qD0zZK2sCSBIBnTdrRoZBwV4R-4ni4GGRiqm_IYTDBbEzl_Ado9IEpXXNBCtxuro3hjhq1i4Z",
                    secretKey:
                        "EM_UQOlrRrI8YBP_6enGU5yR5uvVOtEONPx8UQySg0E0yw7yhiSKarW2Ko6rDI3rkh0jTucc0GdHgOAo",
                    transactions: [
                      {
                        "amount": {
                          "total": amount.toStringAsFixed(2),
                          "currency": "USD",
                          "details": {
                            "subtotal": amount.toStringAsFixed(2),
                            "shipping": '0',
                            "shipping_discount": 0
                          }
                        },
                      }
                    ],
                    note: "Contactanos para cualquier duda sobre su compra.",
                    onSuccess: (Map params) async {
                      log("onSuccess: $params");
                      // try {
                      //   await dataService.updateRoomStatus(
                      //       habitacion.id, 'Ocupado');
                      //   _showAlertAndNavigate(context, "Pago exitoso",
                      //       "Su pago ha sido exitoso.", Colors.green);
                      // } catch (e) {
                      //   log("Error updating room status: ${e.toString()}");
                      //   _showAlertAndNavigate(
                      //       context,
                      //       "Error",
                      //       "Hubo un error actualizando el estado de la habitación.",
                      //       Colors.red);
                      // }
                      _showAlertAndNavigate(context, "Pago exitoso",
                          "Su pago ha sido exitoso.", Colors.green);
                    },
                    onError: (error) {
                      log("onError: $error");
                      _showAlertAndNavigate(context, "Error en el pago",
                          "Hubo un error con su pago.", Colors.red);
                    },
                    onCancel: () {
                      _showAlertAndNavigate(context, "Pago cancelado",
                          "El pago fue cancelado.", Colors.red);
                    },
                  ),
                ));
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.payment,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Pagar con PayPal',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAlertAndNavigate(
      BuildContext context, String title, String message, Color color) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, style: TextStyle(color: color)),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => RoomPage(habitacion: habitacion),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }
}
