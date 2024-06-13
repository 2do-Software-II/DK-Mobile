import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hotel_app/screens/room.dart';
import 'package:hotel_app/theme/color.dart';
import 'package:hotel_app/utils/habitacion_class.dart';
import 'package:hotel_app/widgets/favorite_box.dart';

class FeatureItem extends StatelessWidget {
  final Habitacion habitacion;
  final double width;
  final double height;
  final GestureTapCallback? onTapFavorite;
  final bool isFavorited;

  const FeatureItem({
    super.key,
    required this.habitacion,
    this.width = 280,
    this.height = 280,
    this.onTapFavorite,
    this.isFavorited = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RoomPage(habitacion: habitacion)),
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
              offset: const Offset(1, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(),
            SizedBox(
              height: height - 200,
              child: SingleChildScrollView(
                // Añadir SingleChildScrollView para evitar overflow
                child: Container(
                  width: width - 20,
                  padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildName(),
                      _buildInfo(),
                    ],
                  ),
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
      habitacion.type,
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
                habitacion.status,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColor.labelColor,
                  fontSize: 13,
                ),
              ),
              Text(
                '\$${habitacion.price}',
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
          isFavorited: isFavorited,
        ),
      ],
    );
  }

  Widget _buildImage() {
    if (habitacion.resources.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: habitacion.resources[0].url,
        placeholder: (context, url) => const BlankImageWidget(),
        errorWidget: (context, url, error) => const BlankImageWidget(),
        imageBuilder: (context, imageProvider) => Container(
          width: double.infinity,
          height: 190,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    } else {
      return const BlankImageWidget();
    }
  }
}

class BlankImageWidget extends StatelessWidget {
  const BlankImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 190,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Icon(
        Icons.image,
        color: Colors.grey,
        size: 50,
      ),
    );
  }
}
