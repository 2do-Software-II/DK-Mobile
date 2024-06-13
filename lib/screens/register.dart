// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotel_app/screens/root_app.dart';
import 'package:hotel_app/theme/palette.dart';
import 'package:hotel_app/utils/user_class.dart';
import 'package:hotel_app/widgets/background_image.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatelessWidget {
  Register({super.key});

  final TextEditingController _nombre = TextEditingController();
  final TextEditingController _correo = TextEditingController();
  final TextEditingController _contra = TextEditingController();
  final TextEditingController _confcontra = TextEditingController();

  final FocusNode _nombreFocusNode = FocusNode();
  final FocusNode _correoFocusNode = FocusNode();
  final FocusNode _contraFocusNode = FocusNode();
  final FocusNode _confcontraFocusNode = FocusNode();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        const BackgroundImage(image: 'assets/images/los-tajibos.webp'),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: size.height * 0.07),
                      child: Center(
                        child: CircleAvatar(
                          radius: size.width * 0.14,
                          backgroundColor: Colors.grey[400]!.withOpacity(0.4),
                          child: Icon(
                            FontAwesomeIcons.user,
                            color: Colors.white,
                            size: size.width * 0.15,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: _nombre,
                              focusNode: _nombreFocusNode,
                              autocorrect: false,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey.withOpacity(0.6),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                labelText: "Nombre completo",
                                labelStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                ),
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                errorStyle: const TextStyle(
                                  fontSize: 22,
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Ingrese su nombre";
                                }
                                return null;
                              },
                              onFieldSubmitted: (value) {
                                FocusScope.of(context)
                                    .requestFocus(_correoFocusNode);
                              },
                            ),
                            SizedBox(height: size.height * 0.01),
                            TextFormField(
                              controller: _correo,
                              focusNode: _correoFocusNode,
                              autocorrect: false,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey.withOpacity(0.6),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                labelText: "Correo electronico",
                                labelStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                ),
                                prefixIcon: const Icon(
                                  Icons.mail,
                                  color: Colors.white,
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                errorStyle: const TextStyle(
                                  fontSize: 22,
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Ingrese su correo";
                                }
                                if (!RegExp(
                                        "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                    .hasMatch(value)) {
                                  return "Ingrese un correo electronico valido";
                                }
                                return null;
                              },
                              onFieldSubmitted: (value) {
                                FocusScope.of(context)
                                    .requestFocus(_contraFocusNode);
                              },
                            ),
                            SizedBox(height: size.height * 0.01),
                            TextFormField(
                              controller: _contra,
                              focusNode: _contraFocusNode,
                              autocorrect: false,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.next,
                              obscureText: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey.withOpacity(0.6),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                labelText: "Contraseña",
                                labelStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                ),
                                prefixIcon: const Icon(
                                  Icons.password,
                                  color: Colors.white,
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                errorStyle: const TextStyle(
                                  fontSize: 22,
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Ingrese una contraseña";
                                }
                                return null;
                              },
                              onFieldSubmitted: (value) {
                                FocusScope.of(context)
                                    .requestFocus(_confcontraFocusNode);
                              },
                            ),
                            SizedBox(height: size.height * 0.01),
                            TextFormField(
                              controller: _confcontra,
                              focusNode: _confcontraFocusNode,
                              autocorrect: false,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.done,
                              obscureText: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey.withOpacity(0.6),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                labelText: "Confirmar contraseña",
                                labelStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                ),
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                errorStyle: const TextStyle(
                                  fontSize: 22,
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Ingrese una contraseña";
                                }
                                if (_contra.text != _confcontra.text) {
                                  return "Las contraseñas no coinciden";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: size.height * 0.04),
                            Center(
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                height: 50,
                                minWidth: 200,
                                color: const Color.fromARGB(157, 122, 189, 251),
                                textColor: Colors.white,
                                onPressed: () {
                                  if (_formkey.currentState!.validate()) {
                                    register(_nombre.text, _correo.text,
                                        _contra.text, context);
                                  }
                                },
                                child: const Text(
                                  'Registrarse',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontFamily: 'Dosis',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * 0.02),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Ya tiene una cuenta?',
                                  style: kBodyText,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/Login');
                                  },
                                  child: Text(
                                    'Ingresar',
                                    style: kBodyText.copyWith(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<String?> register(
      String nombre, String correo, String contra, context) async {
    final url =
        Uri.parse("https://jv-gateway-production.up.railway.app/auth/register");

    final resp = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': nombre,
        'email': correo,
        'password': contra,
      }),
    );

    if (resp.statusCode == 200 && resp.body.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Registrado correctamente"),
        ),
      );

      var datos = jsonDecode(resp.body);
      await _guardarDatos(datos['token']);

      User user = User(
        email: correo,
        password: contra,
        name: nombre,
        id: datos['id'] ?? "ID del usuario",
      );

      await _guardarUser(user);

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const RootApp()),
        (route) => false,
      );
    } else {
      print("Error al registrarse: ${resp.statusCode} ${resp.body}");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error al registrarse"),
        ),
      );
    }
    return null;
  }

  Future<void> _guardarUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode(user.toJson()));
  }

  Future<void> _guardarDatos(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }
}
