import 'dart:convert';

import 'package:c3web/containers/courses/html/html_course_list.dart';
import 'package:c3web/containers/courses/css/css_course_list.dart';
import 'package:c3web/containers/courses/js/js_course_list.dart';
import 'package:c3web/containers/exercise/exercise_main.dart';
import 'package:c3web/containers/puzzle/puzzle_main.dart';
import 'package:c3web/containers/quiz/quiz_main.dart';
import 'package:c3web/helpers/image_bytes.dart';
import 'package:c3web/widgets/dashboard/dashboard_header.dart';
import 'package:c3web/widgets/templates/card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

Widget buildCardTop() {
  return CardWidget(
      elevation: 3,
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
                end: Alignment.centerRight,
                begin: Alignment.centerLeft,
                colors: [Color(0xFF387FB8), Color(0xFF8CCDEC)])),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 30),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      "Kursus Terbaik",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                      maxLines: 2,
                    ),
                  ),
                  // Container(
                  //   padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                  //   margin: const EdgeInsets.only(top: 10),
                  //   decoration: BoxDecoration(
                  //       color: const Color(0xFF68BAE3),
                  //       borderRadius: BorderRadius.circular(20)),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       SvgPicture.asset(
                  //         "assets/icon/ic_user.svg",
                  //         color: Colors.white,
                  //       ),
                  //       const Padding(
                  //           padding: EdgeInsets.only(right: 10),
                  //           child: Text(
                  //             "45 orang",
                  //             style: TextStyle(
                  //                 color: Colors.white,
                  //                 fontWeight: FontWeight.w700),
                  //           ))
                  //     ],
                  //   ),
                  // )
                ],
              ),
            ),
          ),
          SizedBox(
            width: 150,
            child: SvgPicture.asset("assets/icon/img_bestcourse.svg"),
          )
        ]),
      ));
}

Widget buildCardCourse(
    String byte, String title, EdgeInsets padding, Function() route) {
  Uint8List bytes = base64.decode(byte);
  return Padding(
    padding: padding,
    child: GestureDetector(
      onTap: () {
        route();
      },
      child: CardWidget(
          elevation: 3,
          child: Container(
              decoration: BoxDecoration(
                  color: const Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.only(left: 28, right: 28, top: 28),
              child: Column(
                children: [
                  Image.memory(
                    bytes,
                    width: 64,
                    height: 64,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ))),
    ),
  );
}

Widget buildCardChallenge(String byte, String title, EdgeInsets padding) {
  Uint8List bytes = base64.decode(byte);

  return Padding(
    padding: padding,
    child: CardWidget(
        elevation: 3,
        borderRadius: 10,
        child: Container(
            padding: const EdgeInsets.fromLTRB(16, 30, 16, 30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFFFAFAFA)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Image.memory(
                  bytes,
                  width: 64,
                  height: 64,
                ),
              ],
            ))),
  );
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(0.0, 0.0),
        child: Container(decoration: const BoxDecoration(color: Colors.white)),
      ),
      body: Container(
          child: Column(
        children: [
          const Stack(
            children: [DashboardHeader()],
          ),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 10, 25, 20),
                  child: buildCardTop(),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Kursus",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 168,
                          padding: const EdgeInsets.only(top: 20),
                          child: ListView(
                              padding: const EdgeInsets.only(bottom: 10),
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              children: [
                                Row(
                                  children: [
                                    buildCardCourse(ImageBytes.imgHtml, "HTML",
                                        const EdgeInsets.only(right: 20), (() {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  const HtmlCourseList())));
                                    })),
                                    buildCardCourse(ImageBytes.imgCss, "CSS",
                                        const EdgeInsets.only(right: 20), (() {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  const CssCourseList())));
                                    })),
                                    buildCardCourse(ImageBytes.imgJs,
                                        "Javascript", EdgeInsets.zero, (() {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  const JsCourseList())));
                                    })),
                                  ],
                                )
                              ]),
                        )
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Tantangan",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        const ExerciseMain())));
                          },
                          child: buildCardChallenge(ImageBytes.imgTraining,
                              "Latihan \nSoal", const EdgeInsets.only(top: 20)),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        const PuzzleMain())));
                          },
                          child: buildCardChallenge(ImageBytes.imgPuzzle,
                              "Puzzle \nCode", const EdgeInsets.only(top: 20)),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => const QuizMain())));
                          },
                          child: buildCardChallenge(ImageBytes.imgQuiz, "Quiz",
                              const EdgeInsets.only(top: 20, bottom: 20)),
                        )
                      ]),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
