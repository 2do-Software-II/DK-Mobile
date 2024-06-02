// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:hotel_app/screens/explore.dart';
import 'package:hotel_app/screens/near.dart';
import 'package:hotel_app/screens/setting.dart';
import 'package:hotel_app/theme/color.dart';
import 'package:hotel_app/utils/constant.dart';
import 'package:hotel_app/widgets/bottombar_item.dart';

import 'home.dart';

class RootApp extends StatefulWidget {
  const RootApp({super.key});

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> with TickerProviderStateMixin {
  int _activeTabIndex = 0;
  final List _barItems = [
    {
      "icon": "assets/icons/home.svg",
      "page": const HomePage(),
    },
    {
      "icon": "assets/icons/search.svg",
      "page": Container(
        alignment: Alignment.center,
        child: const ExploreScreen(),
      ),
    },
    {
      "icon": "assets/icons/pin-area.svg",
      "page": Container(
        alignment: Alignment.center,
        child: HotelListScreen(),
      ),
    },
    {
      "icon": "assets/icons/setting.svg",
      "page": const SettingPage(),
    },
  ];

//====== set animation=====
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: ANIMATED_BODY_MS),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void initState() {
    super.initState();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

  _buildAnimatedPage(page) {
    return FadeTransition(child: page, opacity: _animation);
  }

  void onPageChanged(int index) {
    if (index == _activeTabIndex) return;
    _controller.reset();
    setState(() {
      _activeTabIndex = index;
    });
    _controller.forward();
  }

//====== end set animation=====

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBgColor,
      bottomNavigationBar: _buildBottomBar(),
      body: _buildPage(),
    );
  }

  Widget _buildPage() {
    return IndexedStack(
      index: _activeTabIndex,
      children: List.generate(
        _barItems.length,
        (index) => _buildAnimatedPage(_barItems[index]["page"]),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      height: 75,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.bottomBarColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.shadowColor.withOpacity(0.3),
            blurRadius: 1,
            spreadRadius: 1,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 25,
          right: 25,
          bottom: 15,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            _barItems.length,
            (index) => BottomBarItem(
              _barItems[index]["icon"],
              isActive: _activeTabIndex == index,
              activeColor: AppColor.darker,
              onTap: () => onPageChanged(index),
            ),
          ),
        ),
      ),
    );
  }
}
