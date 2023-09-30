import 'package:c3web/containers/dashboard.dart';
import 'package:c3web/containers/exercise/exercise_one.dart';
import 'package:c3web/containers/exercise/exercise_three.dart';
import 'package:c3web/containers/exercise/exercise_two.dart';
import 'package:c3web/helpers/image_bytes.dart';
import 'package:c3web/widgets/templates/card_border.dart';
import 'package:c3web/widgets/templates/header_back.dart';
import 'package:flutter/material.dart';

class ExerciseMain extends StatefulWidget {
  const ExerciseMain({super.key});

  @override
  State<ExerciseMain> createState() => _ExerciseMainState();
}

class _ExerciseMainState extends State<ExerciseMain>
    with TickerProviderStateMixin {
  late TabController tabController;
  BorderRadiusGeometry borderRadiusTab = const BorderRadius.only(
      topLeft: Radius.circular(10), bottomLeft: Radius.circular(10));
  String search = "";
  final searchController = TextEditingController();

  Widget buildCardMaterial(
      String title, String desc, bool isDone, EdgeInsets margin) {
    return CardBorderWidget(
      margin: margin,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  desc,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
          Container(
            child: Text(
              isDone ? "Selesai" : "Berlangsung",
              style: TextStyle(
                  color: isDone
                      ? const Color(0xFF00FF00)
                      : const Color(0xFFFF0000),
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(0.0, 0.0),
          child: Container(
            decoration: const BoxDecoration(color: Colors.white),
          )),
      body: Container(
          child: Column(
        children: [
          Stack(
            children: [
              HeaderBackWidget(
                title: "Puzzle",
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
                                        const ExerciseOne())));
                          },
                          child: buildCardChallenge(ImageBytes.imgTraining,
                              "Latihan Soal 1", const EdgeInsets.only(top: 20)),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        const ExerciseTwo())));
                          },
                          child: buildCardChallenge(ImageBytes.imgTraining,
                              "Latihan Soal 2", const EdgeInsets.only(top: 20)),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        const ExerciseThree())));
                          },
                          child: buildCardChallenge(ImageBytes.imgTraining,
                              "Latihan Soal 3", const EdgeInsets.only(top: 20)),
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
