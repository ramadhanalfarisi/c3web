import 'dart:async';
import 'dart:io';

import 'package:c3web/db/create_db.dart';
import 'package:c3web/router/main_router.dart';
import 'package:c3web/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DB().initializeDb();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool showSplash = true;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      showSplash = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          canvasColor: Colors.white,
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: const Color(0xff000000),
                displayColor: const Color(0xff000000),
                fontFamily: "Nunito",
              )),
      home: UpgradeAlert(
          upgrader: Upgrader(
              showIgnore: false,
              dialogStyle: Platform.isIOS
                  ? UpgradeDialogStyle.cupertino
                  : UpgradeDialogStyle.material),
          child: showSplash ? const SplashScreen() : const MainRouter()),
    );
  }
}
