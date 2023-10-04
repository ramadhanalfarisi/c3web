import 'package:c3web/containers/puzzle/puzzle_result.dart';
import 'package:c3web/widgets/templates/button.dart';
import 'package:c3web/widgets/templates/header_back.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PuzzleTwo extends StatefulWidget {
  const PuzzleTwo({super.key});

  @override
  State<PuzzleTwo> createState() => _PuzzleTwoState();
}

class _PuzzleTwoState extends State<PuzzleTwo> {
  String data1 = "";
  String data2 = "";
  String data3 = "";
  String data4 = "";
  String data5 = "";
  String dataValue1 = "assets/img/nomor3soal2.svg";
  String dataValue2 = "assets/img/nomor1soal2.svg";
  String dataValue3 = "assets/img/nomor2soal2.svg";
  String dataValue4 = "assets/img/nomor5soal2.svg";
  String dataValue5 = "assets/img/nomor4soal2.svg";
  List<bool> answer = [false, false, false, false, false];
  Map<String, bool> isDropped = {
    "assets/img/nomor1soal2.svg": false,
    "assets/img/nomor2soal2.svg": false,
    "assets/img/nomor3soal2.svg": false,
    "assets/img/nomor4soal2.svg": false,
    "assets/img/nomor5soal2.svg": false
  };
  ScrollController scrollController = ScrollController();
  final _listViewKey = GlobalKey();

  changeDropped(String key, bool value) {
    setState(() {
      isDropped[key] = value;
    });
  }

  getDropped(String key) {
    return isDropped[key];
  }

  scrollingFunction(event) {
    RenderBox render =
        _listViewKey.currentContext?.findRenderObject() as RenderBox;
    Offset position = render.localToGlobal(Offset.zero);
    double topY = position.dy; // top position of the widget
    double bottomY = topY + render.size.height; // bottom position of the widget

    const detectedRange = 100;
    const moveDistance = 3;

    if (event.position.dy < topY + detectedRange) {
      var to = scrollController.offset - moveDistance;
      to = (to < 0) ? 0 : to;
      scrollController.jumpTo(to);
    }
    if (event.position.dy > bottomY - detectedRange) {
      scrollController.jumpTo(scrollController.offset + moveDistance);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size(0, 0),
            child: Container(
              decoration: const BoxDecoration(color: Colors.white),
            )),
        body: Column(children: [
          HeaderBackWidget(
            title: "Puzzle 2",
          ),
          Expanded(
              child: ListView(
                  key: _listViewKey,
                  controller: scrollController,
                  children: [
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text("""
<!DOCTYPE html>
 <html>
"""),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          DragTarget<String>(
                            builder: (
                              BuildContext context,
                              List<dynamic> accepted,
                              List<dynamic> rejected,
                            ) {
                              return DottedBorder(
                                borderType: BorderType.RRect,
                                radius: Radius.circular(12),
                                padding: EdgeInsets.all(6),
                                color: Colors.grey,
                                strokeWidth: 2,
                                dashPattern: [8],
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  child: data1.isNotEmpty
                                      ? SvgPicture.asset(
                                          data1,
                                          width: 200,
                                          height: 20,
                                        )
                                      : SizedBox(
                                          width: 200,
                                          height: 20,
                                        ),
                                ),
                              );
                            },
                            onAccept: (data) {
                              debugPrint('$data');
                              setState(() {
                                data1 = data;
                                if (data == dataValue2) {
                                  answer[0] = true;
                                }
                                isDropped[data] = true;
                              });
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          data1.isNotEmpty
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isDropped[data1] = false;
                                      data1 = "";
                                      answer[0] = false;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.redAccent),
                                    child: Icon(
                                      Icons.undo,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : SizedBox()
                        ],
                      ),
                      SizedBox(height: 10),
                      Text("""
    <head>
    <body background="pancasila.png">
        <br>
        <h1 align=center>PANCASILA</h1>
        <br>
"""),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          DragTarget<String>(
                            builder: (
                              BuildContext context,
                              List<dynamic> accepted,
                              List<dynamic> rejected,
                            ) {
                              return DottedBorder(
                                borderType: BorderType.RRect,
                                radius: Radius.circular(12),
                                padding: EdgeInsets.all(6),
                                color: Colors.grey,
                                strokeWidth: 2,
                                dashPattern: [8],
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  child: data2.isNotEmpty
                                      ? SvgPicture.asset(
                                          data2,
                                          width: 200,
                                          height: 20,
                                        )
                                      : SizedBox(
                                          width: 200,
                                          height: 20,
                                        ),
                                ),
                              );
                            },
                            onAccept: (data) {
                              debugPrint('$data');
                              setState(() {
                                data2 = data;
                                if (data == dataValue3) {
                                  answer[1] = true;
                                }
                                isDropped[data] = true;
                              });
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          data2.isNotEmpty
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isDropped[data2] = false;
                                      data2 = "";
                                      answer[1] = false;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.redAccent),
                                    child: Icon(
                                      Icons.undo,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : SizedBox()
                        ],
                      ),
                      SizedBox(height: 10),
                      Text("""
        <h4>Ketuhanan Yang Maha Esa</h4>
        <br>
        <img src="images.png" width="70" height="80" align="right" hspace="10"
 alt="Lambang Sila Kedua">
        <h4 align=right>Kemanusiaan yang adil dan beradab</h4>
        </br>
        <br>
"""),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          DragTarget<String>(
                            builder: (
                              BuildContext context,
                              List<dynamic> accepted,
                              List<dynamic> rejected,
                            ) {
                              return DottedBorder(
                                borderType: BorderType.RRect,
                                radius: Radius.circular(12),
                                padding: EdgeInsets.all(6),
                                color: Colors.grey,
                                strokeWidth: 2,
                                dashPattern: [8],
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  child: data3.isNotEmpty
                                      ? SvgPicture.asset(
                                          data3,
                                          width: 200,
                                          height: 20,
                                        )
                                      : SizedBox(
                                          width: 200,
                                          height: 20,
                                        ),
                                ),
                              );
                            },
                            onAccept: (data) {
                              debugPrint('$data');
                              setState(() {
                                data3 = data;
                                if (data == dataValue1) {
                                  answer[2] = true;
                                }
                                isDropped[data] = true;
                              });
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          data3.isNotEmpty
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isDropped[data3] = false;
                                      data3 = "";
                                      answer[2] = false;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.redAccent),
                                    child: Icon(
                                      Icons.undo,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : SizedBox()
                        ],
                      ),
                      SizedBox(height: 10),
                      Text("""
            alt="Lambang sila Ketiga">
        <h4>Persatuan Indonesia</h4>
        </br>
        <br>
        <img src="Kepala-Banteng-Sila-Keempat-Pancasila.png" width="70"
 height="80" align="right" hspace="10"
            alt="lambang Sila Keempat">
"""),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          DragTarget<String>(
                            builder: (
                              BuildContext context,
                              List<dynamic> accepted,
                              List<dynamic> rejected,
                            ) {
                              return DottedBorder(
                                borderType: BorderType.RRect,
                                radius: Radius.circular(12),
                                padding: EdgeInsets.all(6),
                                color: Colors.grey,
                                strokeWidth: 2,
                                dashPattern: [8],
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  child: data4.isNotEmpty
                                      ? SvgPicture.asset(
                                          data4,
                                          width: 200,
                                          height: 20,
                                        )
                                      : SizedBox(
                                          width: 200,
                                          height: 20,
                                        ),
                                ),
                              );
                            },
                            onAccept: (data) {
                              debugPrint('$data');
                              setState(() {
                                data4 = data;
                                if (data == dataValue5) {
                                  answer[3] = true;
                                }
                                isDropped[data] = true;
                              });
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          data4.isNotEmpty
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isDropped[data4] = false;
                                      data4 = "";
                                      answer[3] = false;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.redAccent),
                                    child: Icon(
                                      Icons.undo,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : SizedBox()
                        ],
                      ),
                      SizedBox(height: 10),
                      Text("""
            permusyawaratan perwakilan </h4>
        </br>
        <br>
        <img src="download.png" width="70" height="80" align="left" hspace="10"
 alt="Lambang sila Kelima">
"""),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          DragTarget<String>(
                            builder: (
                              BuildContext context,
                              List<dynamic> accepted,
                              List<dynamic> rejected,
                            ) {
                              return DottedBorder(
                                borderType: BorderType.RRect,
                                radius: Radius.circular(12),
                                padding: EdgeInsets.all(6),
                                color: Colors.grey,
                                strokeWidth: 2,
                                dashPattern: [8],
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  child: data5.isNotEmpty
                                      ? SvgPicture.asset(
                                          data5,
                                          width: 200,
                                          height: 20,
                                        )
                                      : SizedBox(
                                          width: 200,
                                          height: 20,
                                        ),
                                ),
                              );
                            },
                            onAccept: (data) {
                              debugPrint('$data');
                              setState(() {
                                data5 = data;
                                if (data == dataValue4) {
                                  answer[4] = true;
                                }
                                isDropped[data] = true;
                              });
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          data5.isNotEmpty
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isDropped[data5] = false;
                                      data5 = "";
                                      answer[4] = false;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.redAccent),
                                    child: Icon(
                                      Icons.undo,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : SizedBox()
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("""
    </body>
 </html>
"""),
                      SizedBox(height: 30),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Cocokkan jawaban dibawah ini.",
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              !getDropped(dataValue1)
                                  ? Listener(
                                      onPointerMove: (PointerMoveEvent event) {
                                        scrollingFunction(event);
                                      },
                                      child: Draggable<String>(
                                        // Data is the value this Draggable stores.
                                        data: dataValue1,
                                        child: Container(
                                          height: 60.0,
                                          width: 200.0,
                                          child: SvgPicture.asset(dataValue1,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width),
                                        ),
                                        feedback: Container(
                                          height: 60.0,
                                          width: 200.0,
                                          child: SvgPicture.asset(dataValue1,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width),
                                        ),
                                        //New
                                        childWhenDragging: Container(),
                                      ),
                                    )
                                  : SizedBox(),
                              !getDropped(dataValue2)
                                  ? Listener(
                                      onPointerMove: (PointerMoveEvent event) {
                                        scrollingFunction(event);
                                      },
                                      child: Draggable<String>(
                                        // Data is the value this Draggable stores.
                                        data: dataValue2,
                                        child: Container(
                                          height: 60.0,
                                          width: 200.0,
                                          child: SvgPicture.asset(dataValue2,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width),
                                        ),
                                        feedback: Container(
                                          height: 60.0,
                                          width: 200.0,
                                          child: SvgPicture.asset(dataValue2,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width),
                                        ),
                                        //New
                                        childWhenDragging: Container(),
                                      ),
                                    )
                                  : SizedBox(),
                              !getDropped(dataValue3)
                                  ? Listener(
                                      onPointerMove: (PointerMoveEvent event) {
                                        scrollingFunction(event);
                                      },
                                      child: Draggable<String>(
                                        // Data is the value this Draggable stores.
                                        data: dataValue3,
                                        child: Container(
                                          height: 60.0,
                                          width: 200.0,
                                          child: SvgPicture.asset(dataValue3,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width),
                                        ),
                                        feedback: Container(
                                          height: 60.0,
                                          width: 200.0,
                                          child: SvgPicture.asset(dataValue3,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width),
                                        ),
                                        //New
                                        childWhenDragging: Container(),
                                      ),
                                    )
                                  : SizedBox(),
                              !getDropped(dataValue4)
                                  ? Listener(
                                      onPointerMove: (PointerMoveEvent event) {
                                        scrollingFunction(event);
                                      },
                                      child: Draggable<String>(
                                        // Data is the value this Draggable stores.
                                        data: dataValue4,
                                        child: Container(
                                          height: 60.0,
                                          width: 200.0,
                                          child: SvgPicture.asset(dataValue4,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width),
                                        ),
                                        feedback: Container(
                                          height: 60.0,
                                          width: 200.0,
                                          child: SvgPicture.asset(dataValue4,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width),
                                        ),
                                        //New
                                        childWhenDragging: Container(),
                                      ),
                                    )
                                  : SizedBox(),
                              !getDropped(dataValue5)
                                  ? Listener(
                                      onPointerMove: (PointerMoveEvent event) {
                                        scrollingFunction(event);
                                      },
                                      child: Draggable<String>(
                                        // Data is the value this Draggable stores.
                                        data: dataValue5,
                                        child: Container(
                                          height: 60.0,
                                          width: 200.0,
                                          child: SvgPicture.asset(dataValue5,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width),
                                        ),
                                        feedback: Container(
                                          height: 60.0,
                                          width: 200.0,
                                          child: SvgPicture.asset(dataValue5,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width),
                                        ),
                                        //New
                                        childWhenDragging: Container(),
                                      ),
                                    )
                                  : SizedBox()
                            ]),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Button(
                        text: "Kumpulkan",
                        onPress: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => PuzzleResult(
                                        answers: answer,
                                      )),
                              (Route<dynamic> route) => false);
                        })
                  ],
                )
              ]))
        ]));
  }
}
