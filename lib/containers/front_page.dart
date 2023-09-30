import 'dart:convert';

import 'package:c3web/containers/dashboard.dart';
import 'package:c3web/helpers/colors.dart';
import 'package:c3web/helpers/image_bytes.dart';
import 'package:c3web/widgets/templates/button.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FrontPage extends StatefulWidget {
  const FrontPage({super.key});

  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  bool isload = false;
  CarouselController carouselController = CarouselController();
  int pageIndex = 0;
  List<Map<String, dynamic>> itemsCarousel = [
    {
      'image': base64.decode(ImageBytes.imgHtml),
      'text':
          "Tujuan dari pembelajaran materi HTML pada media pembelajaran ini yaitu: \nPeserta didik dapat menerapkan kerangka HTML 5, menerapkan macam-macam format teks, menerapkan format tabel, menerapkan format list pada halaman web, menyisipkan gambar, audio, dan video pada halaman web, membuat tautan antar halaman web, dan membuat tampilan formulir pada halaman web."
    },
    {
      'image': base64.decode(ImageBytes.imgCss),
      'text':
          "Tujuan dari pembelajaran materi CSS pada media pembelajaran ini yaitu: \nPeserta didik dapat menjelaskan konsep CSS, menerapkan format penulisan CSS, menerapkan tata cara peletakan style CSS, menerapkan property dasar pada CSS, menjelaskan konsep CSS Responsive, menerapkan penulisan media query, dan menerapkan konsep grid."
    },
    {
      'image': base64.decode(ImageBytes.imgJs),
      'text':
          "Tujuan dari pembelajaran materi Javascript pada media pembelajaran yaitu: \nPeserta didik dapat menjelaskan konsep Javascript, Menjelasakan format penulisan javascript, menjelaskan konsep perubahan style elemen menggunakan javascript, membuat kode javascript dengan menerapkan event pada elemen HTML, dan membuat kode javasvript manipulasi value, style, dan konten dinamis pada elemen HTML"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: isload
          ? Center(
              child: LoadingAnimationWidget.discreteCircle(
                  color: ColorConfig.primaryColor, size: 50))
          : Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: CarouselSlider.builder(
                      carouselController: carouselController,
                      itemCount: 3,
                      itemBuilder: (context, itemIndex, pageIndex) {
                        return Column(
                          children: [
                            Image.memory(
                              itemsCarousel[itemIndex]["image"],
                              height: 100,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                              child: Text(
                                itemsCarousel[itemIndex]['text'],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        );
                      },
                      options: CarouselOptions(
                          height: MediaQuery.of(context).size.height - 150,
                          scrollPhysics: const NeverScrollableScrollPhysics(),
                          viewportFraction: 1,
                          initialPage: 0,
                          enableInfiniteScroll: false,
                          enlargeCenterPage: false,
                          autoPlay: false,
                          enlargeFactor: 0.3,
                          scrollDirection: Axis.horizontal,
                          pageSnapping: true)),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      pageIndex < 2
                          ? Button(
                              text: "Selanjutnya",
                              onPress: () {
                                carouselController.nextPage();
                                setState(() {
                                  pageIndex += 1;
                                });
                              })
                          : Button(
                              padding: const EdgeInsets.fromLTRB(32, 8, 32, 8),
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
                                        builder: (context) =>
                                            const Dashboard()),
                                    (Route<dynamic> route) => false);
                              }),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
