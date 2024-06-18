// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotel_app/screens/root_app.dart';
import 'package:hotel_app/utils/customer_class.dart';
import 'package:hotel_app/utils/data_service.dart';
import 'package:hotel_app/utils/user_class.dart';
import 'package:hotel_app/widgets/background_image.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatelessWidget {
  Register({super.key});

  final TextEditingController _nombre = TextEditingController();
  final TextEditingController _apellido = TextEditingController();
  final TextEditingController _telefono = TextEditingController();
  final TextEditingController _direccion = TextEditingController();
  final TextEditingController _ci = TextEditingController();
  final TextEditingController _expedicion = TextEditingController();
  final TextEditingController _fechaNacimiento = TextEditingController();
  final TextEditingController _nacionalidad = TextEditingController();
  final TextEditingController _genero = TextEditingController();
  final TextEditingController _preferencia = TextEditingController();
  final TextEditingController _correo = TextEditingController();
  final TextEditingController _contra = TextEditingController();
  final TextEditingController _confcontra = TextEditingController();

  final FocusNode _nombreFocusNode = FocusNode();
  final FocusNode _apellidoFocusNode = FocusNode();
  final FocusNode _telefonoFocusNode = FocusNode();
  final FocusNode _direccionFocusNode = FocusNode();
  final FocusNode _ciFocusNode = FocusNode();
  final FocusNode _expedicionFocusNode = FocusNode();
  final FocusNode _fechaNacimientoFocusNode = FocusNode();
  final FocusNode _nacionalidadFocusNode = FocusNode();
  final FocusNode _generoFocusNode = FocusNode();
  final FocusNode _preferenciaFocusNode = FocusNode();
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
                            // Nombre
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
                                labelText: "Nombre",
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
                                    .requestFocus(_apellidoFocusNode);
                              },
                            ),
                            // Apellido
                            SizedBox(height: size.height * 0.01),
                            TextFormField(
                              controller: _apellido,
                              focusNode: _apellidoFocusNode,
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
                                labelText: "Apellido",
                                labelStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                ),
                                prefixIcon: const Icon(
                                  Icons.person_outline,
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
                                  return "Ingrese su apellido";
                                }
                                return null;
                              },
                              onFieldSubmitted: (value) {
                                FocusScope.of(context)
                                    .requestFocus(_telefonoFocusNode);
                              },
                            ),
                            // Teléfono
                            SizedBox(height: size.height * 0.01),
                            TextFormField(
                              controller: _telefono,
                              focusNode: _telefonoFocusNode,
                              autocorrect: false,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                              keyboardType: TextInputType.phone,
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
                                labelText: "Teléfono",
                                labelStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                ),
                                prefixIcon: const Icon(
                                  Icons.phone,
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
                                  return "Ingrese su teléfono";
                                }
                                return null;
                              },
                              onFieldSubmitted: (value) {
                                FocusScope.of(context)
                                    .requestFocus(_direccionFocusNode);
                              },
                            ),
                            // Dirección
                            SizedBox(height: size.height * 0.01),
                            TextFormField(
                              controller: _direccion,
                              focusNode: _direccionFocusNode,
                              autocorrect: false,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                              keyboardType: TextInputType.streetAddress,
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
                                labelText: "Dirección",
                                labelStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                ),
                                prefixIcon: const Icon(
                                  Icons.home,
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
                                  return "Ingrese su dirección";
                                }
                                return null;
                              },
                              onFieldSubmitted: (value) {
                                FocusScope.of(context)
                                    .requestFocus(_ciFocusNode);
                              },
                            ),
                            // CI
                            SizedBox(height: size.height * 0.01),
                            TextFormField(
                              controller: _ci,
                              focusNode: _ciFocusNode,
                              autocorrect: false,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                              keyboardType: TextInputType.number,
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
                                labelText: "CI",
                                labelStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                ),
                                prefixIcon: const Icon(
                                  Icons.badge,
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
                                  return "Ingrese su CI";
                                }
                                return null;
                              },
                              onFieldSubmitted: (value) {
                                FocusScope.of(context)
                                    .requestFocus(_expedicionFocusNode);
                              },
                            ),
                            // Expedición
                            SizedBox(height: size.height * 0.01),
                            TextFormField(
                              controller: _expedicion,
                              focusNode: _expedicionFocusNode,
                              autocorrect: false,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                              keyboardType: TextInputType.text,
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
                                labelText: "Expedición",
                                labelStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                ),
                                prefixIcon: const Icon(
                                  Icons.local_airport,
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
                                  return "Ingrese su expedición";
                                }
                                return null;
                              },
                              onFieldSubmitted: (value) {
                                FocusScope.of(context)
                                    .requestFocus(_fechaNacimientoFocusNode);
                              },
                            ),
                            // Fecha de Nacimiento
                            SizedBox(height: size.height * 0.01),
                            TextFormField(
                              controller: _fechaNacimiento,
                              focusNode: _fechaNacimientoFocusNode,
                              autocorrect: false,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                              keyboardType: TextInputType.datetime,
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
                                labelText: "Fecha de Nacimiento",
                                labelStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                ),
                                prefixIcon: const Icon(
                                  Icons.calendar_today,
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
                                  return "Ingrese su fecha de nacimiento";
                                }
                                return null;
                              },
                              onFieldSubmitted: (value) {
                                FocusScope.of(context)
                                    .requestFocus(_nacionalidadFocusNode);
                              },
                            ),
                            // Nacionalidad
                            SizedBox(height: size.height * 0.01),
                            TextFormField(
                              controller: _nacionalidad,
                              focusNode: _nacionalidadFocusNode,
                              autocorrect: false,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                              keyboardType: TextInputType.text,
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
                                labelText: "Nacionalidad",
                                labelStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                ),
                                prefixIcon: const Icon(
                                  Icons.flag,
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
                                  return "Ingrese su nacionalidad";
                                }
                                return null;
                              },
                              onFieldSubmitted: (value) {
                                FocusScope.of(context)
                                    .requestFocus(_generoFocusNode);
                              },
                            ),
                            // Género
                            SizedBox(height: size.height * 0.01),
                            TextFormField(
                              controller: _genero,
                              focusNode: _generoFocusNode,
                              autocorrect: false,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                              keyboardType: TextInputType.text,
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
                                labelText: "Género",
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
                                  return "Ingrese su género";
                                }
                                return null;
                              },
                              onFieldSubmitted: (value) {
                                FocusScope.of(context)
                                    .requestFocus(_preferenciaFocusNode);
                              },
                            ),
                            // Preferencia
                            SizedBox(height: size.height * 0.01),
                            TextFormField(
                              controller: _preferencia,
                              focusNode: _preferenciaFocusNode,
                              autocorrect: false,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                              keyboardType: TextInputType.text,
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
                                labelText: "Preferencia",
                                labelStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                ),
                                prefixIcon: const Icon(
                                  Icons.star,
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
                                  return "Ingrese su preferencia";
                                }
                                return null;
                              },
                              onFieldSubmitted: (value) {
                                FocusScope.of(context)
                                    .requestFocus(_correoFocusNode);
                              },
                            ),
                            // Correo
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
                                labelText: "Correo electrónico",
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
                                  return "Ingrese un correo electrónico válido";
                                }
                                return null;
                              },
                              onFieldSubmitted: (value) {
                                FocusScope.of(context)
                                    .requestFocus(_contraFocusNode);
                              },
                            ),
                            // Contraseña
                            SizedBox(height: size.height * 0.01),
                            TextFormField(
                              controller: _contra,
                              focusNode: _contraFocusNode,
                              autocorrect: false,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),
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
                                return null;
                              },
                              onFieldSubmitted: (value) {
                                FocusScope.of(context)
                                    .requestFocus(_confcontraFocusNode);
                              },
                            ),
                            // Confirmar Contraseña
                            SizedBox(height: size.height * 0.01),
                            TextFormField(
                              controller: _confcontra,
                              focusNode: _confcontraFocusNode,
                              autocorrect: false,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),
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
                                labelText: "Confirmar Contraseña",
                                labelStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                ),
                                prefixIcon: const Icon(
                                  Icons.lock_outline,
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
                                  return "Confirme su contraseña";
                                }
                                if (value != _contra.text) {
                                  return "Las contraseñas no coinciden";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: size.height * 0.05),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 15,
                                      ),
                                    ),
                                    child: const Text(
                                      "REGISTRARSE",
                                      style: TextStyle(
                                        fontSize: 22,
                                      ),
                                    ),
                                    onPressed: () async {
                                      if (_formkey.currentState!.validate()) {
                                        await registerUser(
                                          _nombre.text,
                                          _apellido.text,
                                          _telefono.text,
                                          _direccion.text,
                                          _ci.text,
                                          _expedicion.text,
                                          _fechaNacimiento.text,
                                          _nacionalidad.text,
                                          _genero.text,
                                          _preferencia.text,
                                          _correo.text,
                                          _contra.text,
                                          context,
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.05),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> registerUser(
    String name,
    String lastName,
    String phone,
    String address,
    String ci,
    String expedition,
    String birthDate,
    String nationality,
    String gender,
    String preference,
    String email,
    String password,
    BuildContext context,
  ) async {
    final Map<String, dynamic> body = {
      'name': name,
      'email': email,
      'password': password,
    };
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await http.post(
      Uri.parse('https://jv-gateway-production.up.railway.app/auth/register'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      var userId = jsonResponse['user'];
      User newUser = User(
        email: email,
        password: password,
        name: name,
        id: userId,
      );

      Customer newCustomer = Customer(
        id: userId,
        name: name,
        lastName: lastName,
        phone: phone,
        address: address,
        ci: ci,
        expedition: expedition,
        birthDate: birthDate,
        nationality: nationality,
        gender: gender,
        preference: preference,
      );

      prefs.setString('user', jsonEncode(newUser.toJson()));
      prefs.setString('customer', jsonEncode(newCustomer.toJson()));

      var custId = await DataService().createCustomer(newCustomer, context);

      print(custId);
      print(userId);

      prefs.setString('customerId', custId);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const RootApp()),
        (route) => false,
      );
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error')),
      );
    }
  }
}
