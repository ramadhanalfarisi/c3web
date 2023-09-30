import 'package:c3web/containers/dashboard.dart';
import 'package:c3web/helpers/colors.dart';
import 'package:c3web/widgets/templates/button.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FrontPage extends StatefulWidget {
  const FrontPage({super.key});

  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  bool isload = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: isload
          ? Center(
              child: LoadingAnimationWidget.discreteCircle(
                  color: ColorConfig.primaryColor, size: 50))
          : Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Lottie.asset('assets/lotties/ils_getstarted.json'),
                  const Text(
                    "Mengasah Keterampilan Web Anda dengan Lebih Cepat dan Lebih Efektif!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF244F83),
                        fontWeight: FontWeight.w700),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      "Selamat datang di C3Web, Kami telah merancang aplikasi ini untuk membantu Anda memahami dan menguasai bahasa pemrograman utama dalam pengembangan web. Tunggu apa lagi?",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Button(
                      padding: const EdgeInsets.fromLTRB(32, 8, 32, 8),
                      margin: const EdgeInsets.only(top: 40),
                      text: "Mulai Sekarang",
                      onPress: () async {
                        // change isload into true
                        setState(() {
                          isload = true;
                        });

                        // set isGetStarted variable into true
                        SharedPreferences sp =
                            await SharedPreferences.getInstance();
                        await sp.setBool("isGetStarted", true);

                        // redirect to dashboard page
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const Dashboard()),
                            (Route<dynamic> route) => false);
                      })
                ],
              )),
    );
  }
}
