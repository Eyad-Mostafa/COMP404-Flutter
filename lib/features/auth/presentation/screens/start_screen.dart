import 'package:comp404_flutter/features/auth/presentation/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/app_button.dart';
import 'login_screen.dart';


class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
        child: Column(
          children: [
            const Spacer(flex: 2),

            ///Logo
            buildLogo(size),

            SizedBox(height: size.height * 0.02),

            ///Title
            buildTitle(size),

            SizedBox(height: size.height * 0.06),

            ///Subtitle
            buildSubtitle(size),

            const Spacer(flex: 3),

            ///Register Button
            AppButton(
              text: 'Get Started',
              onPressed: () => Get.to(() => RegisterScreen()),
            ),

            SizedBox(height: size.height * 0.02),

            ///Login Button
            AppButton(
              text: 'I already have an account',
              isOutlined: true,
              onPressed: () => Get.to(() => LoginScreen()),
            ),

            SizedBox(height: size.height * 0.04),
          ],
        ),
      ),
    );
  }
  Widget buildLogo(Size size) {
    return Image.asset(
      'assets/logo/logo.png',
      width: size.width * 0.5,
      height: size.height * 0.2,
      fit: BoxFit.contain,
    );
  }

  Widget buildTitle(Size size) {
    return Text(
      'Welcome to\nByte Riders',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: size.width * 0.08,
        fontWeight: FontWeight.bold,
        color: Color(0xFF60269E),
      ),
    );
  }

  Widget buildSubtitle(Size size) {
    return Text(
      'Start the engine. Own the road.',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: size.width * 0.045,
        height: 1.4,
      ),
    );
  }
}