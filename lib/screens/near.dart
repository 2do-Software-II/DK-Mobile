import 'package:flutter/material.dart';
import 'package:hotel_app/utils/hotel_class.dart';
import 'package:hotel_app/widgets/hotel_card.dart';

class HotelListScreen extends StatelessWidget {
  final List<Hotel> hotels = [
    Hotel(
      name: 'Sofitel',
      rating: 4.5,
      reviews: 275,
      location: 'Phnom Penh',
      imageUrl:
          'https://images.unsplash.com/photo-1570129462341-e93d60104453?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
    ),
    Hotel(
      name: 'Rose Wood',
      rating: 4.5,
      reviews: 275,
      location: 'Phnom Penh',
      imageUrl:
          'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
    ),
    Hotel(
      name: 'The Bale',
      rating: 4.5,
      reviews: 275,
      location: 'Phnom Penh',
      imageUrl:
          'https://images.unsplash.com/photo-1587054243694-519524561f1a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
    ),
    Hotel(
      name: 'Raffles',
      rating: 4.5,
      reviews: 275,
      location: 'Phnom Penh',
      imageUrl:
          'https://images.unsplash.com/photo-1607997367968-8d56f848367b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
    ),
    Hotel(
      name: 'La Rose',
      rating: 4.5,
      reviews: 275,
      location: 'Phnom Penh',
      imageUrl:
          'https://images.unsplash.com/photo-1563492065596-22568199a0b7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
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
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_pin),
            label: 'Location',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
