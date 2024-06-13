// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app/screens/formulario_reserva.dart';
import 'package:hotel_app/screens/root_app.dart';
import 'package:hotel_app/utils/habitacion_class.dart';
import 'package:hotel_app/widgets/feature_item.dart';

class RoomPage extends StatefulWidget {
  final Habitacion habitacion;

  const RoomPage({super.key, required this.habitacion});

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigator.pop(context);
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => RootApp(),
              ),
              (Route<dynamic> route) => false,
            );
          },
        ),
        actions: const [
          Icon(Icons.more_vert),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageSlider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.habitacion.type,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Estado: ${widget.habitacion.status}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: const [
                      Icon(Icons.star,
                          color: Color.fromARGB(255, 255, 206, 59), size: 18),
                      SizedBox(width: 4),
                      Text('4.5'),
                      SizedBox(width: 8),
                      Text('10 reviews'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Servicios incluidos',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _offerItem('assets/icons/twinbed.png', 'Twin Bed'),
                      _offerItem('assets/icons/wifi.png', 'Wifi'),
                      _offerItem('assets/icons/parking.png', 'Parking'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Descripcion',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.habitacion.description,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (widget.habitacion.status == 'Disponible') {
                          _showConfirmBooking();
                        } else {
                          _showStatusMessage(widget.habitacion.status);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 48, vertical: 16),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      child: const Text('Reserva Ya!'),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showStatusMessage(String status) {
    String message;
    switch (status) {
      case 'Ocupado':
        message = 'La habitación está ocupada.';
        break;
      case 'Mantenimiento':
        message = 'La habitación está en mantenimiento.';
        break;
      case 'En limpieza':
        message = 'La habitación está en limpieza.';
        break;
      default:
        message = 'La habitación no está disponible.';
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Estado de la Habitación'),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildImageSlider() {
    return SizedBox(
      height: 250,
      child: PageView.builder(
        itemCount: widget.habitacion.resources.length,
        itemBuilder: (context, index) {
          return CachedNetworkImage(
            imageUrl: widget.habitacion.resources[index].url,
            placeholder: (context, url) => const BlankImageWidget(),
            errorWidget: (context, url, error) => const BlankImageWidget(),
            imageBuilder: (context, imageProvider) => Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _showConfirmBooking() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        message: const Text("Desea reservar esta habitacion?"),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingFormScreen(
                    habitacion: widget.habitacion,
                  ),
                ),
              );
            },
            child: const Text(
              "SI",
              style:
                  TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            ),
          )
        ],
        cancelButton: CupertinoActionSheetAction(
          child: const Text("NO"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}

Widget _offerItem(String iconAsset, String title) {
  return Column(
    children: [
      Image.asset(
        iconAsset,
        height: 30,
        width: 30,
      ),
      const SizedBox(height: 8),
      Text(
        title,
        style: const TextStyle(fontSize: 14),
      ),
    ],
  );
}
