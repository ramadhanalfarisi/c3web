import 'package:c3web/containers/courses/js/materials/function.dart';
import 'package:c3web/containers/courses/js/materials/introduction.dart';
import 'package:c3web/containers/courses/js/materials/operator.dart';
import 'package:c3web/containers/courses/js/materials/type_data.dart';
import 'package:c3web/db/js_course_db.dart';
import 'package:c3web/helpers/colors.dart';
import 'package:c3web/widgets/templates/card_border.dart';
import 'package:c3web/widgets/templates/header_back.dart';
import 'package:c3web/widgets/templates/textfield.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class JsCourseList extends StatefulWidget {
  const JsCourseList({super.key});

  @override
  State<JsCourseList> createState() => _JsCourseListState();
}

class _JsCourseListState extends State<JsCourseList> {
  String search = '';
  late Box<JsCourse> box;
  List<JsCourse> listTopic = [];
  bool isloading = true;
  final searchController = TextEditingController();

  initializeBox() async {
    box = await Hive.openBox<JsCourse>('js_course_box');
    List<JsCourse> list = [];
    for (var i = 0; i < box.length; i++) {
      list.add(box.getAt(i)!);
    }
    listTopic = list;
    setState(() {});
  }

  @override
  void initState() {
    initializeBox();
    isLoading();
    super.initState();
  }

  isLoading() {
    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        setState(() {
          isloading = false;
        });
      },
    );
  }

  searchTopic() {
    List<JsCourse> list = [];
    for (var i = 0; i < box.length; i++) {
      String title = box.getAt(i)!.title.toLowerCase();
      String description = box.getAt(i)!.description.toLowerCase();
      if (title.contains(search) || description.contains(search)) {
        list.add(box.getAt(i)!);
      }
    }
    setState(() {
      listTopic = list;
    });
  }

  Widget buildCardMaterial(int id, String title, String desc,
      int progressMateri, int progressInteraktif, EdgeInsets margin) {
    return GestureDetector(
      onTap: () {
        if (id == 1) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Introduction()));
        } else if (id == 2) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const TypeData()));
        } else if (id == 3) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Operator()));
        } else if (id == 4) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const FormatFunction()));
        }
      },
      child: CardBorderWidget(
        margin: margin,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
                progressMateri >= 100 && progressInteraktif >= 100
                    ? "Selesai"
                    : "Berlangsung",
                style: TextStyle(
                    color: progressMateri >= 100 && progressInteraktif >= 100
                        ? const Color.fromARGB(255, 29, 155, 29)
                        : const Color(0xFFFF0000),
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
              ),
            )
          ],
        ),
      ),
    );
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
          Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderBackWidget(),
                  Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: RichText(
                          text: const TextSpan(children: [
                        TextSpan(
                          text: "JS",
                          style: TextStyle(
                              color: ColorConfig.primaryTextColor,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Nunito"),
                        ),
                        TextSpan(
                          text: "\n(JavaScript)",
                          style: TextStyle(
                              color: ColorConfig.primaryTextColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Nunito"),
                        )
                      ]))),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 10),
                    child: TextFieldWidget(
                      controller: searchController,
                      onChanged: (text) {
                        setState(() {
                          search = text;
                        });
                        searchTopic();
                      },
                      hint: "Cari",
                      width: MediaQuery.of(context).size.width,
                    ),
                  )
                ],
              )
            ],
          ),
          Expanded(
            child: isloading
                ? const SizedBox()
                : RefreshIndicator(
                    onRefresh: () async {
                      setState(() {});
                    },
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        int totalProgressInt = 0;
                        for (int progress
                            in listTopic[index].progressInteraktif) {
                          totalProgressInt += progress;
                        }
                        totalProgressInt = (totalProgressInt /
                                listTopic[index].progressInteraktif.length)
                            .floor();
                        return buildCardMaterial(
                          listTopic[index].id,
                          listTopic[index].title,
                          listTopic[index].description,
                          listTopic[index].progressMateri,
                          totalProgressInt,
                          const EdgeInsets.only(top: 10, right: 20, left: 20),
                        );
                      },
                      itemCount: listTopic.length,
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
