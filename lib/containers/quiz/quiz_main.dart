import 'package:c3web/containers/dashboard.dart';
import 'package:c3web/containers/quiz/css_quiz_form.dart';
import 'package:c3web/containers/quiz/html_quiz_form.dart';
import 'package:c3web/helpers/image_bytes.dart';
import 'package:c3web/widgets/templates/header_back.dart';
import 'package:flutter/material.dart';

class QuizMain extends StatefulWidget {
  const QuizMain({super.key});

  @override
  State<QuizMain> createState() => _QuizMainState();
}

class _QuizMainState extends State<QuizMain> {
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
          Stack(
            children: [
              HeaderBackWidget(
                title: "Quiz",
              )
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        const HtmlQuizForm())));
                          },
                          child: buildCardChallenge(ImageBytes.imgHtml, "HTML",
                              const EdgeInsets.only(top: 20)),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        const CssQuizForm())));
                          },
                          child: buildCardChallenge(ImageBytes.imgCss, "CSS",
                              const EdgeInsets.only(top: 20)),
                        )
                      ]),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
