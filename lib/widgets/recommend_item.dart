import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hotel_app/screens/room.dart';
import 'package:hotel_app/theme/color.dart';
import 'package:hotel_app/utils/habitacion_class.dart';

class RecommendItem extends StatelessWidget {
  const RecommendItem({
    super.key,
    required this.habitacion,
  });

  final Habitacion habitacion;

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
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(10),
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(1, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            _buildImage(),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: buildInfo(),
            )
          ],
        ),
      ),
    );
  }

  Widget buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          habitacion.type,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: AppColor.textColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          habitacion.status,
          style: const TextStyle(
            fontSize: 12,
            color: AppColor.labelColor,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        _buildRateAndPrice(),
      ],
    );
  }

  Widget _buildRateAndPrice() {
    return Row(
      children: [
        const Icon(
          Icons.star,
          size: 14,
          color: AppColor.yellow,
        ),
        const SizedBox(
          width: 3,
        ),
        const Expanded(
          child: Text(
            "4.5",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
        Text(
          '\$${habitacion.price.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColor.primary,
          ),
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
          width: 90,
          height: 90,
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
      width: 90,
      height: 90,
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
