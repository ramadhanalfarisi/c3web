import 'package:c3web/containers/dashboard.dart';
import 'package:c3web/containers/puzzle/puzzle_one.dart';
import 'package:c3web/containers/puzzle/puzzle_two.dart';
import 'package:c3web/helpers/image_bytes.dart';
import 'package:c3web/widgets/templates/header_back.dart';
import 'package:flutter/material.dart';

class PuzzleMain extends StatefulWidget {
  const PuzzleMain({super.key});

  @override
  State<PuzzleMain> createState() => _PuzzleMainState();
}

class _PuzzleMainState extends State<PuzzleMain> {
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
                                    builder: ((context) => const PuzzleOne())));
                          },
                          child: buildCardChallenge(ImageBytes.imgPuzzle,
                              "Puzzle 1", const EdgeInsets.only(top: 20)),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => const PuzzleTwo())));
                          },
                          child: buildCardChallenge(ImageBytes.imgPuzzle,
                              "Puzzle 2", const EdgeInsets.only(top: 20)),
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
