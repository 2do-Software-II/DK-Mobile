// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:hotel_app/screens/room.dart';
import 'package:hotel_app/theme/color.dart';
import 'package:hotel_app/widgets/favorite_box.dart';
import 'custom_image.dart';

class FeatureItem extends StatelessWidget {
  const FeatureItem({
    super.key,
    required this.data,
    this.width = 280,
    this.height = 300,
    this.onTapFavorite,
  });

  final data;
  final double width;
  final double height;
  final GestureTapCallback? onTapFavorite;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RoomPage()),
        );
      },
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColor.shadowColor.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(1, 1), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(),
            SizedBox(
              height: height - 220, // Reducir el espacio del contenedor interno
              child: Container(
                width: width - 20,
                padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildName(),
                    const SizedBox(
                      height: 2,
                    ),
                    _buildInfo(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildName() {
    return Text(
      data["name"],
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 18,
        color: AppColor.textColor,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildInfo() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data["type"],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColor.labelColor,
                  fontSize: 13,
                ),
              ),
              Text(
                data["price"],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColor.primary,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        FavoriteBox(
          size: 16,
          onTap: onTapFavorite,
          isFavorited: data["is_favorited"],
        ),
      ],
    );
  }

  Widget _buildImage() {
    return CustomImage(
      data["image"],
      width: double.infinity,
      height: 190,
      radius: 15,
    );
  }
}
