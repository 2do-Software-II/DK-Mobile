// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotel_app/theme/palette.dart';
import 'package:hotel_app/widgets/background_image.dart';
import 'package:hotel_app/widgets/rounded_button.dart';
import 'package:hotel_app/widgets/text_input.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(children: [
      const BackgroundImage(
        image: 'assets/images/cortez.jpeg',
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          title: const Text(
            'Restablecer Contraseña',
            style: kBodyText,
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  SizedBox(
                    width: size.width * 0.8,
                    child: const Text(
                      'Ingrese su correo para enviarle las instrucciones de la nueva contraseña.',
                      style: kBodyText,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const TextInput(
                    icon: FontAwesomeIcons.envelope,
                    hint: 'Correo',
                    inputType: TextInputType.emailAddress,
                    inputAction: TextInputAction.done,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const RoundedButton(
                    buttonText: 'Enviar',
                  ),
                ],
              ),
            )
          ],
        ),
      )
    ]);
  }
}
