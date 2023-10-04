import 'dart:math';

import 'package:c3web/containers/quiz/quiz_result.dart';
import 'package:c3web/db/js_quiz_db.dart';
import 'package:c3web/helpers/colors.dart';
import 'package:c3web/widgets/templates/button.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';

class JsQuizForm extends StatefulWidget {
  const JsQuizForm({super.key});

  @override
  State<JsQuizForm> createState() => _JsQuizFormState();
}

class _JsQuizFormState extends State<JsQuizForm> {
  List<Widget> carouselQuiz = [];
  List<String> answers = [];
  List<String> currentAnswers = [];
  late Box<JsQuiz> box;
  String currentKey = "";
  CarouselController carouselController = CarouselController();
  List<int> randomInt = [];

  @override
  void initState() {
    super.initState();
    getRandomInt();
    initializeBox();
  }

  getRandomInt() {
    Random random = Random();
    List<int> ints = [];
    for (var i = 0; i < 10; i++) {
      int rand = 0;
      do {
        rand = random.nextInt(10);
      } while (ints.contains(rand));
      ints.add(rand);
    }
    setState(() {
      randomInt = ints;
    });
  }

  initializeBox() async {
    box = await Hive.openBox<JsQuiz>('js_quiz_box');
    List<Widget> car = [];
    List<String> ans = [];
    for (var i = 0; i < box.length; i++) {
      car.add(buildCarousel(box.getAt(randomInt[i])!));
      ans.add(box.getAt(randomInt[i])!.answer);
    }
    carouselQuiz = car;
    answers = ans;
    setState(() {});
  }

  buildCarousel(JsQuiz quiz) {
    return ListView(children: [
      Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          quiz.image != null && quiz.image!.isNotEmpty
              ? SvgPicture.asset(
                  quiz.image!,
                  width: MediaQuery.of(context).size.width,
                )
              : const SizedBox(),
          Text(
            quiz.question,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(
            height: 10,
          ),
          ...buildOptions(quiz)
        ]),
      ),
    ]);
  }

  buildOptions(JsQuiz quiz) {
    List<Widget> optionsList = [];
    for (var element in quiz.options) {
      final key = element["key"] as String;
      final text = element["text"] as String;
      final option = GestureDetector(
        onTap: () {
          setState(() {
            currentKey = key;
          });
          initializeBox();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: currentKey == key
                    ? ColorConfig.primaryColor
                    : const Color.fromARGB(255, 75, 74, 74)),
            color: currentKey == key ? ColorConfig.primaryColor : Colors.white,
          ),
          child: Row(
            children: [
              Text(
                key,
                style: TextStyle(
                    color: currentKey == key ? Colors.white : Colors.black),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                text,
                style: TextStyle(
                    color: currentKey == key ? Colors.white : Colors.black),
                maxLines: 3,
              )
            ],
          ),
        ),
      );
      optionsList.add(option);
    }
    return optionsList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(0, 0),
          child: Container(
            decoration: const BoxDecoration(color: Colors.white),
          )),
      body: Column(
        children: [
          CarouselSlider(
              items: carouselQuiz,
              carouselController: carouselController,
              options: CarouselOptions(
                  height: MediaQuery.of(context).size.height - 130,
                  scrollPhysics: const NeverScrollableScrollPhysics(),
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: false,
                  autoPlay: false,
                  enlargeFactor: 0.3,
                  scrollDirection: Axis.horizontal,
                  pageSnapping: true)),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Button(
                text: "Save",
                onPress: () {
                  if (currentKey.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Kamu harus memilih satu jawaban"),
                    ));
                  } else {
                    if (currentAnswers.length == 9) {
                      List<String> currAnswer = currentAnswers;
                      currAnswer.add(currentKey);
                      setState(() {
                        currentKey = "";
                        currentAnswers = currAnswer;
                      });
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => QuizResult(
                                    answers: answers,
                                    currentAnswers: currentAnswers,
                                  )),
                          (Route<dynamic> route) => false);
                    } else {
                      carouselController.nextPage();
                      Future.delayed(const Duration(milliseconds: 100), () {
                        List<String> currAnswer = currentAnswers;
                        currAnswer.add(currentKey);
                        setState(() {
                          currentKey = "";
                          currentAnswers = currAnswer;
                        });
                        initializeBox();
                      });
                    }
                  }
                })
          ])
        ],
      ),
    );
  }
}
