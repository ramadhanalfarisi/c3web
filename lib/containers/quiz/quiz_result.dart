import 'package:c3web/containers/dashboard.dart';
import 'package:c3web/helpers/colors.dart';
import 'package:c3web/widgets/templates/header_back.dart';
import 'package:flutter/material.dart';

class QuizResult extends StatefulWidget {
  final List<String> answers;
  final List<String> currentAnswers;
  const QuizResult({super.key, required this.answers, required this.currentAnswers});

  @override
  State<QuizResult> createState() => _QuizResultState();
}

class _QuizResultState extends State<QuizResult> {
  int grade = 0;

  @override
  void initState() {
    super.initState();
    calculateGrade();
  }

  calculateGrade() {
    int g = 0;
    for (var i = 0; i < 10; i++) {
      if (widget.answers[i] == widget.currentAnswers[i]) {
        g += 10;
      }
    }
    setState(() {
      grade = g;
    });
  }

  String get getGreetings {
    if (grade >= 0 && grade <= 60) {
      return "Belajar Lagi Yaa!";
    } else if (grade > 60 && grade <= 90) {
      return "Nilai kamu udah memuaskan";
    } else {
      return "Yeaahh!! kamu berhasil";
    }
  }

  String get getGreetings2 {
    if (grade >= 0 && grade <= 60) {
      return "Tetap Semangat";
    } else if (grade > 60 && grade <= 90) {
      return "Tinggal dikit lagi";
    } else {
      return "Kamu udah menguasai materi";
    }
  }

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
                title: "Hasil Quiz",
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const Dashboard()),
                      (Route<dynamic> route) => false);
                },
              )
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          getGreetings,
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          getGreetings2,
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.normal),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          grade.toString(),
                          style: const TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              color: ColorConfig.primaryColor),
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
