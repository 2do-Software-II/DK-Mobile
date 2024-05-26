import 'package:flutter/material.dart';
import 'package:hotel_app/theme/color.dart';

class IconBox extends StatelessWidget {
  const IconBox({
    super.key,
    required this.child,
    this.bgColor = Colors.white,
    this.onTap,
    this.borderColor = Colors.transparent,
    this.radius = 50,
    this.padding = 5,
    this.isShadow = true,
  });

  final Widget child;
  final Color borderColor;
  final Color bgColor;
  final double radius;
  final double padding;
  final GestureTapCallback? onTap;
  final bool isShadow;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: borderColor),
          boxShadow: [
            if (isShadow)
              BoxShadow(
                color: AppColor.shadowColor.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 1), // changes position of shadow
              ),
          ],
        ),
        child: child,
      ),
    );
  }
}
