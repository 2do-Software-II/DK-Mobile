// ignore_for_file: avoid_print

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app/theme/color.dart';
import 'package:hotel_app/utils/data.dart';
import 'package:hotel_app/utils/data_service.dart';
import 'package:hotel_app/utils/habitacion_class.dart';
import 'package:hotel_app/widgets/feature_item.dart';
import 'package:hotel_app/widgets/notification_box.dart';
import 'package:hotel_app/widgets/city_item.dart';
import 'package:hotel_app/widgets/recommend_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Habitacion> habitaciones = [];
  List<Habitacion> habitacionesRecomendadas = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchHabitaciones();
    fetchHabitacionesRecomendadas();
  }

  Future<void> fetchHabitaciones() async {
    try {
      final dataService = DataService();
      final fetchedHabitaciones = await dataService.fetchAllRooms();
      setState(() {
        habitaciones = fetchedHabitaciones;
        isLoading = false;
      });
    } catch (e) {
      // Manejo de errores
      print('Error fetching habitaciones: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchHabitacionesRecomendadas() async {
    try {
      final dataService = DataService();
      final fetchedHabitacionesRecomendadas =
          await dataService.fetchAllRoomsRecommended('USER_ID');
      setState(() {
        habitacionesRecomendadas = fetchedHabitacionesRecomendadas;
      });
    } catch (e) {
      // Manejo de errores
      print('Error fetching habitaciones recomendadas: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBgColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColor.appBarColor,
            pinned: true,
            snap: true,
            floating: true,
            title: _builAppBar(),
          ),
          SliverToBoxAdapter(
            child: _buildBody(),
          ),
        ],
      ),
    );
  }

  Widget _builAppBar() {
    return const Row(
      children: [
        Icon(
          Icons.place_outlined,
          color: AppColor.labelColor,
          size: 20,
        ),
        SizedBox(
          width: 3,
        ),
        Text(
          "Santa Cruz",
          style: TextStyle(
            color: AppColor.darker,
            fontSize: 13,
          ),
        ),
        Spacer(),
        NotificationBox(
          notifiedNumber: 1,
        )
      ],
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 5, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 5),
            child: Text(
              "Encuentra y reserva!",
              style: TextStyle(
                color: AppColor.labelColor,
                fontSize: 14,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
            child: Text(
              "Las Mejores Habitaciones",
              style: TextStyle(
                color: AppColor.textColor,
                fontWeight: FontWeight.w600,
                fontSize: 22,
              ),
            ),
          ),
          _buildCities(),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
            child: Text(
              "Destacadas",
              style: TextStyle(
                color: AppColor.textColor,
                fontWeight: FontWeight.w500,
                fontSize: 22,
              ),
            ),
          ),
          _buildFeatured(),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Recomendaciones",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: AppColor.textColor),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    "See all",
                    style: TextStyle(fontSize: 14, color: AppColor.darker),
                  ),
                ),
              ],
            ),
          ),
          _getRecommend(),
        ],
      ),
    );
  }

  _buildFeatured() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return CarouselSlider(
      options: CarouselOptions(
        height: 300,
        enlargeCenterPage: true,
        disableCenter: true,
        viewportFraction: .75,
      ),
      items: habitaciones.map((habitacion) {
        return FeatureItem(
          habitacion: habitacion,
        );
      }).toList(),
    );
  }

  _getRecommend() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: habitacionesRecomendadas.map((habitacion) {
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: RecommendItem(
              habitacion: habitacion,
            ),
          );
        }).toList(),
      ),
    );
  }

  _buildCities() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(15, 5, 0, 10),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          cities.length,
          (index) => Padding(
            padding: const EdgeInsets.only(right: 8),
            child: CityItem(
              data: cities[index],
            ),
          ),
        ),
      ),
    );
  }
}
