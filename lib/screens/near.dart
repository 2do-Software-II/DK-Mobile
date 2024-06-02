// lib/screens/hotel_list_screen.dart

import 'package:flutter/material.dart';
import 'package:hotel_app/utils/hotel_class.dart';
import 'package:hotel_app/widgets/hotel_card.dart';

class HotelListScreen extends StatelessWidget {
  final List<Hotel> hotels = [
    Hotel(
      name: 'Hotel Cortez',
      rating: 4.5,
      reviews: 275,
      location: 'Phnom Penh',
      imageUrl: "assets/images/cortez.jpeg",
    ),
    Hotel(
      name: 'Catedral',
      rating: 4.5,
      reviews: 275,
      location: 'Phnom Penh',
      imageUrl: "assets/images/catedral-24-sept.jpeg",
    ),
    Hotel(
      name: 'Los Tajibos',
      rating: 4.5,
      reviews: 275,
      location: 'Phnom Penh',
      imageUrl: "assets/images/los-tajibos.webp",
    ),
    Hotel(
      name: 'Rey Palace',
      rating: 4.5,
      reviews: 275,
      location: 'Phnom Penh',
      imageUrl: "assets/images/rey-palace.jpeg",
    ),
  ];

  HotelListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: hotels.length,
        itemBuilder: (context, index) {
          final hotel = hotels[index];
          return HotelCard(hotel: hotel);
        },
      ),
    );
  }
}
