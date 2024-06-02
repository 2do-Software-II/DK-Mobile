import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotel_app/theme/color.dart';

class BottomBarItem extends StatelessWidget {
  const BottomBarItem(
    this.icon, {
    super.key,
    this.onTap,
    this.color = const Color.fromARGB(255, 52, 50, 50),
    this.activeColor = AppColor.primary,
    this.isActive = false,
  });

  final String icon;
  final Color color;
  final Color activeColor;
  final bool isActive;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn,
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: AppColor.bottomBarColor,
            boxShadow: [
              if (isActive)
                BoxShadow(
                  color:
                      const Color.fromARGB(255, 214, 160, 0).withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: const Offset(0, 0), // changes position of shadow
                ),
            ],
          ),
          child: SvgPicture.asset(
            icon,
            colorFilter: ColorFilter.mode(
              isActive ? const Color.fromARGB(255, 223, 134, 0) : color,
              BlendMode.srcIn,
            ),
            width: 20,
            height: 20,
          )),
    );
  }
}
