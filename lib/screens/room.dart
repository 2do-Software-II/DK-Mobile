import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app/theme/color.dart';

class RoomPage extends StatefulWidget {
  const RoomPage({super.key});

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
            Navigator.pop(context);
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
            Stack(
              children: [
                Image.asset(
                  'assets/images/doble.jpeg', // Replace with your actual image path
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                const Positioned(
                  top: 10,
                  right: 10,
                  child: Icon(
                    Icons.favorite,
                    color: Colors.yellow,
                    size: 30,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Twin Room',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Phnom Penh',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    children: [
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
                    'What they offer',
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
                    'Description',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document.',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        _showConfirmBooking();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 48, vertical: 16),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      child: const Text('Book Now'),
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

  _showConfirmBooking() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        message: const Text("Would you like to book this room?"),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {},
            child: const Text(
              "Yes",
              style:
                  TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            ),
          )
        ],
        cancelButton: CupertinoActionSheetAction(
          child: const Text("No"),
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
