// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotel_app/screens/login.dart';
import 'package:hotel_app/screens/reservas.dart';
import 'package:hotel_app/theme/color.dart';
import 'package:hotel_app/utils/data.dart';
import 'package:hotel_app/utils/user_class.dart';
import 'package:hotel_app/widgets/icon_box.dart';
import 'package:hotel_app/widgets/setting_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late Future<User?> _userFuture;
  String _customerId = '';

  @override
  void initState() {
    super.initState();
    _userFuture = _getUser();
  }

  Future<User?> _getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');
    _customerId = prefs.getString('customerId')!;

    if (userJson != null) {
      Map<String, dynamic> userMap = jsonDecode(userJson);
      return User.fromJson(userMap);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBgColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColor.appBarColor,
            pinned: true,
            snap: true,
            floating: true,
            title: _buildAppBar(),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildBody(),
              childCount: 1,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Expanded(
          child: Text(
            "Setting",
            style: TextStyle(
              color: AppColor.textColor,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        IconBox(
          bgColor: AppColor.appBgColor,
          child: SvgPicture.asset(
            "assets/icons/edit.svg",
            width: 18,
            height: 18,
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(right: 20, top: 10),
      child: Column(
        children: [
          _buildProfile(),
          const SizedBox(height: 40),
          const SettingItem(
            title: "Configuracion",
            leadingIcon: Icons.settings,
            leadingIconColor: AppColor.orange,
          ),
          const SizedBox(height: 10),
          SettingItem(
            title: "Reservas",
            leadingIcon: Icons.bookmark_border,
            leadingIconColor: AppColor.blue,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyBookingsScreen(
                    customerId: _customerId,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          const SettingItem(
            title: "Favoritos",
            leadingIcon: Icons.favorite,
            leadingIconColor: AppColor.red,
          ),
          const SizedBox(height: 10),
          const SettingItem(
            title: "Privacidad",
            leadingIcon: Icons.privacy_tip_outlined,
            leadingIconColor: AppColor.green,
          ),
          const SizedBox(height: 10),
          SettingItem(
            title: "Cerrar Sesion",
            leadingIcon: Icons.logout_outlined,
            leadingIconColor: Colors.grey.shade400,
            onTap: () {
              _showConfirmLogout();
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildProfile() {
    return FutureBuilder<User?>(
      future: _userFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text('Error al cargar el perfil');
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Text('No se encontró el usuario');
        } else {
          User user = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              children: <Widget>[
                ClipOval(
                  child: Image.network(
                    profile["image"]!,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  user.email,
                  style: const TextStyle(
                    color: AppColor.textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "Bienvenido",
                  style: TextStyle(
                    color: AppColor.labelColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  _showConfirmLogout() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        message: const Text("Le gustaría cerrar sesión?"),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () async {
              // Eliminar el token del usuario
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove('token');
              await prefs.remove('user');

              // Redirigir a la página de login sin posibilidad de volver atrás
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (route) => false,
              );
            },
            child: const Text(
              "Salir",
              style: TextStyle(color: AppColor.actionColor),
            ),
          )
        ],
        cancelButton: CupertinoActionSheetAction(
          child: const Text("Cancelar"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
