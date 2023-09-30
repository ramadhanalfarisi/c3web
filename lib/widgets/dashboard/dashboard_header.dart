import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DashboardHeader extends StatefulWidget {
  const DashboardHeader({super.key});

  @override
  State<DashboardHeader> createState() => _DashboardHeaderState();
}

class _DashboardHeaderState extends State<DashboardHeader> {
  String search = '';
  final controller = TextEditingController();

  // set search value function
  void setSearch(String text) {
    setState(() {
      search = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SvgPicture.asset(
              "assets/icon/logo.svg",
              semanticsLabel: 'easyWeb Logo',
              height: 50,
            )
          ],
        ));
  }
}
