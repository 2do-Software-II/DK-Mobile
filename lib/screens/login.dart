// ignore_for_file: file_names, prefer_const_constructors, deprecated_member_use, body_might_complete_normally_nullable, unused_local_variable, unused_import, avoid_print
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hotel_app/screens/forgot_password.dart';
import 'package:hotel_app/screens/register.dart';
import 'package:hotel_app/screens/root_app.dart';
import 'package:hotel_app/theme/palette.dart';
import 'package:hotel_app/utils/user_class.dart';
import 'package:hotel_app/widgets/background_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    String email = "";

    TextEditingController contra = TextEditingController();

    final GlobalKey<FormState> formkey = GlobalKey<FormState>();

    return Stack(
      children: [
        const BackgroundImage(
          image: 'assets/images/cortez.jpeg',
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(
                    height: 180,
                    child: Center(
                      child: Text(
                        'Hotel Booking',
                        style: kHeading,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 170,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        Form(
                          key: formkey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Ingrese su correo electronico";
                                  }
                                  if (!RegExp(
                                          "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                      .hasMatch(value)) {
                                    return "Ingrese un correo electronico valido";
                                  }
                                  return null;
                                },
                                autocorrect: false,
                                keyboardType: TextInputType.emailAddress,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color.fromARGB(197, 101, 124, 136),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  labelText: "Correo electronico",
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.alternate_email_rounded,
                                    color: Colors.white,
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  errorStyle: const TextStyle(
                                    fontSize: 22,
                                  ),
                                ),
                                onChanged: (value) => email = value,
                              ),
                              SizedBox(height: 8),
                              TextFormField(
                                controller: contra,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Ingrese una contraseña";
                                  }
                                  return null;
                                },
                                autocorrect: false,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                ),
                                obscureText: true,
                                obscuringCharacter: '*',
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color.fromARGB(197, 101, 124, 136),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  labelText: "Contraseña",
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                  ),
                                  prefixIcon: Icon(
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
                              ),
                              SizedBox(height: 3),
                              GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              const ForgotPassword())),
                                  child: Text(
                                    'Olvide mi contraseña',
                                    style: kBodyText,
                                  )),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 150,
                            ),
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 50,
                              minWidth: 200,
                              color: Color.fromARGB(157, 122, 189, 251),
                              textColor: Colors.white,
                              onPressed: () {
                                if (formkey.currentState!.validate()) {
                                  _login(email, contra.text, context);
                                }
                              },
                              child: const Text(
                                'Ingresar',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: 'Dosis',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: (() => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => Register()))),
                              child: Text(
                                'Crear nueva cuenta',
                                style: kBodyText,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Future<String?> _login(String correo, String contra, context) async {
  final url = Uri.parse(
      "https://jv-gateway-production.up.railway.app/auth/authenticate");

  final resp = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({'email': correo, 'password': contra}),
  );

  if (resp.statusCode == 200 && resp.body.isNotEmpty) {
    var datos = jsonDecode(resp.body);
    await _guardarDatos(datos['token']);

    User user = User(
        email: correo,
        password: contra,
        name: datos['name'] ?? "Nombre del usuario",
        id: datos['id'] ?? "ID del usuario");

    await _guardarUser(user);

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const RootApp()),
      (route) => false,
    );
  } else {
    print("Error al iniciar sesión: ${resp.statusCode} ${resp.body}");

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Error al iniciar sesión"),
      ),
    );
  }
}

Future<void> _guardarUser(User user) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('user', jsonEncode(user.toJson()));
}

Future<void> _guardarDatos(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
}
