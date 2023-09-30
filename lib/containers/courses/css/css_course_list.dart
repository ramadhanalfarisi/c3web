import 'package:c3web/containers/courses/css/materials/format_background.dart';
import 'package:c3web/containers/courses/css/materials/format_border.dart';
import 'package:c3web/containers/courses/css/materials/format_dimension.dart';
import 'package:c3web/containers/courses/css/materials/format_grid.dart';
import 'package:c3web/containers/courses/css/materials/format_media_query.dart';
import 'package:c3web/containers/courses/css/materials/format_navigation.dart';
import 'package:c3web/containers/courses/css/materials/format_overflow.dart';
import 'package:c3web/containers/courses/css/materials/format_responsive.dart';
import 'package:c3web/containers/courses/css/materials/format_text.dart';
import 'package:c3web/containers/courses/css/materials/format_text_mutliple.dart';
import 'package:c3web/containers/courses/css/materials/introduction.dart';
import 'package:c3web/db/css_course_db.dart';
import 'package:c3web/helpers/colors.dart';
import 'package:c3web/widgets/templates/card_border.dart';
import 'package:c3web/widgets/templates/header_back.dart';
import 'package:c3web/widgets/templates/textfield.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CssCourseList extends StatefulWidget {
  const CssCourseList({super.key});

  @override
  State<CssCourseList> createState() => _CssCourseListState();
}

class _CssCourseListState extends State<CssCourseList> {
  String search = '';
  late Box<CssCourse> box;
  List<CssCourse> listTopic = [];
  bool isloading = true;
  final searchController = TextEditingController();

  initializeBox() async {
    box = await Hive.openBox<CssCourse>('css_course_box');
    List<CssCourse> list = [];
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
    List<CssCourse> list = [];
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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const FormatBackground()));
        } else if (id == 3) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const FormatDimension()));
        } else if (id == 4) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const FormatTextCSS()));
        } else if (id == 5) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const FormatBorder()));
        } else if (id == 6) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const FormatOverflow()));
        } else if (id == 7) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const FormatNavigation()));
        } else if (id == 8) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const FormatMultipleColumn()));
        } else if (id == 9) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const FormatMediaQuery()));
        } else if (id == 10) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const FormatGrid()));
        } else if (id == 11) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const FormatResponsive()));
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
                          text: "CSS",
                          style: TextStyle(
                              color: ColorConfig.primaryTextColor,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Nunito"),
                        ),
                        TextSpan(
                          text: "\n(Cascading Style Sheets)",
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
                            const EdgeInsets.only(
                                top: 10, right: 20, left: 20));
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
