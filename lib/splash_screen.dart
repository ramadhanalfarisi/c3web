import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size(0, 0),
            child: Container(
              decoration: const BoxDecoration(color: Colors.white),
            )),
        body: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icon/logo.svg",
                  semanticsLabel: 'C3Web Logo',
                  height: 60,
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/icon/logo-GCC-2023.png",
                      height: 60,
                      width: 60,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Image.asset(
                      "assets/icon/Logo-GEC.jpeg",
                      height: 60,
                      width: 60,
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
