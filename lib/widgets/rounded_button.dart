// ignore_for_file: file_names, unused_import

import 'package:flutter/material.dart';
import 'package:hotel_app/theme/palette.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    super.key,
    required this.buttonText,
  });

  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(16),
      ),
      // ignore: deprecated_member_use
      child: FloatingActionButton(
        onPressed: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            buttonText,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
