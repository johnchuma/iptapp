// ignore_for_file: implementation_imports

import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:iptapp/controllers/auth_controller.dart';
import 'package:iptapp/pages/home_page.dart';
import 'package:iptapp/pages/login_page.dart';

class WayPage extends StatelessWidget {
  const WayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<AuthController>(
      init: AuthController(),
      builder: (find) {
        return find.user == null? const LoginPage():const HomePage();
      }
    );
  }
}