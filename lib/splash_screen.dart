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
                  semanticsLabel: 'easyWeb Logo',
                  height: 80,
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/icon/logo_jatim.png",
                      height: 60,
                      width: 60,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Image.asset(
                      "assets/icon/acerlogo-2024.png",
                      height: 60,
                      width: 60,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/icon/assa2024.png",
                      height: 60,
                      width: 60,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Image.asset(
                      "assets/icon/logo_moklet.png",
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
