// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AppColor {
  static const primary = Color(0xFFe6b56c);
  static const secondary = Color(0xFFe96561);

  static const mainColor = Color(0xFF000000);
  static const darker = Color(0xFF3E4249);
  static const appBgColor = Color.fromARGB(255, 247, 247, 247);
  static const appBarColor = Color(0xFFF7F7F7);
  static const bottomBarColor = Colors.white;
  static const inActiveColor = Colors.grey;
  static const shadowColor = Colors.black87;
  static const textBoxColor = Colors.white;
  static const textColor = Color(0xFF333333);
  static const labelColor = Color(0xFF8A8989);

  static const actionColor = Color(0xFFe54140);
  static const buttonColor = Color(0xFFcdacf9);
  static const cardColor = Colors.white;

  static const yellow = Color(0xFFffcb66);
  static const green = Color(0xFFa2e1a6);
  static const pink = Color(0xFFf5bde8);
  static const purple = Color(0xFFcdacf9);
  static const red = Color(0xFFf77080);
  static const orange = Color(0xFFf5ba92);
  static const sky = Color(0xFFABDEE6);
  static const blue = Color(0xFF509BE4);
  static const cyan = Color(0xFF4ac2dc);
  static const darkerGreen = Color(0xFFb0d96d);

  static const listColors = [
    green,
    purple,
    yellow,
    orange,
    sky,
    secondary,
    red,
    blue,
    pink,
    yellow,
  ];
}

Future<void> createBookiing(
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
  final Map<String, dynamic> body = {
    'date': date,
    'time': time,
    'checkIn': "",
    'checkOut': "",
    'paymentMethod': paymentMethod,
    'startDate': startDate,
    'endeDate': endDate,
    'customer': customer,
    'room': room,
    'status': status,
    'fullPayment': fullPayment,
  };
  print(body);
  print("Enviando datos...");
  var response = await http.post(
    Uri.parse('https://jv-gateway-production.up.railway.app/test/booking'),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(body),
  );
  print("Datos enviados!");
  print(response.body);
  if (response.statusCode == 200) {
    try {
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
    } catch (e) {
      print('Error al decodificar la respuesta JSON: $e');
    }
  } else {
    print('Error en la respuesta del servidor: ${response.statusCode}');
  }
}

//  GET
Future<void> createBoooking(
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
  final queryParameters = {
    'startDate': startDate,
    'endDate': endDate,
    'fullPayment': fullPayment.toString(),
  };

  final url = 'https://jv-gateway-production.up.railway.app/test/booking/' +
      room +
      '/' +
      customer +
      '?startDate=' +
      startDate +
      '&endDate=' +
      endDate +
      '&fullPayment=' +
      fullPayment.toString();

  print("Enviando datos...");

  var response = await http.get(
    Uri.parse(url),
  );

  print("Datos enviados!");
  print(url);
  print("Cuerpo de la respuesta:");
  print(response.body);
  print(response.statusCode);

  if (response.statusCode == 200) {
    if (response.body.isNotEmpty) {
      try {
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
      } catch (e) {
        print('Error al decodificar la respuesta JSON: $e');
      }
    } else {
      print('La respuesta está vacía.');
    }
  } else {
    print('Error en la respuesta del servidor: ${response.statusCode}');
  }
}
