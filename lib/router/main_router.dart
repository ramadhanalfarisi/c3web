import 'package:c3web/containers/dashboard.dart';
import 'package:c3web/containers/front_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainRouter extends StatefulWidget {
  const MainRouter({super.key});

  @override
  State<MainRouter> createState() => _MainRouterState();
}

class _MainRouterState extends State<MainRouter> {
  bool isGetStarted = false;

  @override
  void initState() {
    super.initState();
    getPreferences();
  }

  // get get started status in local storage
  getPreferences() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    isGetStarted = sp.getBool("isGetStarted") ?? false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (isGetStarted) {
      return const Dashboard();
    } else {
      return const FrontPage();
    }
  }
}
