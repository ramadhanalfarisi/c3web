import 'package:c3web/helpers/db_helper.dart';
import 'package:c3web/widgets/courses/tag.dart';
import 'package:c3web/widgets/templates/button.dart';
import 'package:c3web/widgets/templates/header_back.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/theme_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class FormatGrid extends StatefulWidget {
  const FormatGrid({super.key});

  @override
  State<FormatGrid> createState() => _FormatGridState();
}

class _FormatGridState extends State<FormatGrid>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  BorderRadiusGeometry borderRadiusTab = const BorderRadius.only(
      topLeft: Radius.circular(10), bottomLeft: Radius.circular(10));
  String tag = 'grid';
  final codeController = TextEditingController();
  String codeEditor = "";
  String codeEditorTemp = "";
  bool isedit = false;
  late WebViewController wvcontroller;
  late WebViewController wvcontroller2;
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
    Factory(() => EagerGestureRecognizer())
  };

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    tabController.animation!.addListener(tabListener);
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }
    DbHelper.updateDbMateriProgressCss(9);
    wvcontroller = WebViewController.fromPlatformCreationParams(params);
    wvcontroller2 = WebViewController.fromPlatformCreationParams(params);
    wvcontroller.enableZoom(true);
    wvcontroller2.enableZoom(true);
    wvcontroller.loadHtmlString(textExeInteraktif());
    wvcontroller2.loadHtmlString("""<style></style>""");
    super.initState();
  }

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  tabListener() {
    if (tabController.indexIsChanging) {
      switch (tabController.index) {
        case 0:
          setState(() {
            borderRadiusTab = const BorderRadius.only(
                topLeft: Radius.circular(10), bottomLeft: Radius.circular(10));
          });
          break;
        case 1:
          DbHelper.updateDbInteraktifProgressCss(9, 0, 100);
          setState(() {
            borderRadiusTab = BorderRadius.zero;
          });
          break;
        case 2:
          setState(() {
            borderRadiusTab = const BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10));
          });
          break;
      }
    }
  }

  void setCodeEditor(String text) {
    setState(() {
      codeEditor = text;
    });
  }

  String textInteraktif() {
    return """<!DOCTYPE html>\n<html lang="en" dir="ltr">\n  <head>\n    <meta charset="utf-8" />\n    <meta name="viewport" content="width=device-width, initial-scale=1.0" />\n    <title>Background</title>\n    <style>\n      * {\n        box-sizing: border-box;\n      }\n\n      [class*="col-"] {\n        float: left;\n        padding: 15px;\n      }\n\n      /* For Smartphone */\n      [class*="col-"] {\n        width: 100%;\n      }\n\n      @media only screen and (min-width: 600px) {\n        /* For tablets: */\n        .col-s-1 {\n          width: 8.33%;\n        }\n        .col-s-2 {\n          width: 16.66%;\n        }\n        .col-s-3 {\n          width: 25%;\n        }\n        .col-s-4 {\n          width: 33.33%;\n        }\n        .col-s-5 {\n          width: 41.66%;\n        }\n        .col-s-6 {\n          width: 50%;\n        }\n        .col-s-7 {\n          width: 58.33%;\n        }\n        .col-s-8 {\n          width: 66.66%;\n        }\n        .col-s-9 {\n          width: 75%;\n        }\n        .col-s-10 {\n          width: 83.33%;\n        }\n        .col-s-11 {\n          width: 91.66%;\n        }\n        .col-s-12 {\n          width: 100%;\n        }\n      }\n\n      @media only screen and (min-width: 768px) {\n        /* For desktop: */\n        .col-1 {\n          width: 8.33%;\n        }\n        .col-2 {\n          width: 16.66%;\n        }\n        .col-3 {\n          width: 25%;\n        }\n        .col-4 {\n          width: 33.33%;\n        }\n        .col-5 {\n          width: 41.66%;\n        }\n        .col-6 {\n          width: 50%;\n        }\n        .col-7 {\n          width: 58.33%;\n        }\n        .col-8 {\n          width: 66.66%;\n        }\n        .col-9 {\n          width: 75%;\n        }\n        .col-10 {\n          width: 83.33%;\n        }\n        .col-11 {\n          width: 91.66%;\n        }\n        .col-12 {\n          width: 100%;\n        }\n      }\n\n      .bg-green {\n        background: #00510c;\n        color: white;\n      }\n      .bg-blue {\n        background: #012051;\n        color: white;\n      }\n      .bg-red {\n        background: #50011a;\n        color: white;\n      }\n    </style>\n  </head>\n  <body>\n    <h3>Grid 4</h3>\n    <div class="col-3 col-s-6 bg-red">\n      Satu layar dibagi menjadi 4 bagian, jadi tiap kotak berukuran 3\n    </div>\n    <div class="col-3 col-s-6 bg-blue">\n      Satu layar dibagi menjadi 4 bagian, jadi tiap kotak berukuran 3\n    </div>\n    <div class="col-3 col-s-6 bg-green">\n      Satu layar dibagi menjadi 4 bagian, jadi tiap kotak berukuran 3\n    </div>\n    <div class="col-3 col-s-6 bg-red">\n      Satu layar dibagi menjadi 4 bagian, jadi tiap kotak berukuran 3\n    </div>\n    <h3>Grid 3</h3>\n    <div class="col-4 bg-green">\n      Satu layar dibagi menjadi 3 bagian, tiap bagian berukuran 4\n    </div>\n    <div class="col-4 bg-red">\n      Satu layar dibagi menjadi 3 bagian, tiap bagian berukuran 4\n    </div>\n    <div class="col-4 bg-blue">\n      Satu layar dibagi menjadi 3 bagian, tiap bagian berukuran 4\n    </div>\n    <h3>Grid 2</h3>\n    <div class="col-6 bg-green">\n      Satu layar dibagi menjadi 2 bagian, tiap bagian berukuran 6\n    </div>\n    <div class="col-6 bg-red">\n      Satu layar dibagi menjadi 2 bagian, tiap bagian berukuran 6\n    </div>\n  </body>\n</html>""";
  }

  String textExeInteraktif() {
    return """<!DOCTYPE html><html lang="en" dir="ltr">  <head>    <meta charset="utf-8" />    <meta name="viewport" content="width=device-width, initial-scale=1.0" />    <title>Background</title>    <style>      * {        box-sizing: border-box;      }      [class*="col-"] {        float: left;        padding: 15px;      }      /* For Smartphone */      [class*="col-"] {        width: 100%;      }      @media only screen and (min-width: 600px) {        /* For tablets: */        .col-s-1 {          width: 8.33%;        }        .col-s-2 {          width: 16.66%;        }        .col-s-3 {          width: 25%;        }        .col-s-4 {          width: 33.33%;        }        .col-s-5 {          width: 41.66%;        }        .col-s-6 {          width: 50%;        }        .col-s-7 {          width: 58.33%;        }        .col-s-8 {          width: 66.66%;        }        .col-s-9 {          width: 75%;        }        .col-s-10 {          width: 83.33%;        }        .col-s-11 {          width: 91.66%;        }        .col-s-12 {          width: 100%;        }      }      @media only screen and (min-width: 768px) {        /* For desktop: */        .col-1 {          width: 8.33%;        }        .col-2 {          width: 16.66%;        }        .col-3 {          width: 25%;        }        .col-4 {          width: 33.33%;        }        .col-5 {          width: 41.66%;        }        .col-6 {          width: 50%;        }        .col-7 {          width: 58.33%;        }        .col-8 {          width: 66.66%;        }        .col-9 {          width: 75%;        }        .col-10 {          width: 83.33%;        }        .col-11 {          width: 91.66%;        }        .col-12 {          width: 100%;        }      }      .bg-green {        background: #00510c;        color: white;      }      .bg-blue {        background: #012051;        color: white;      }      .bg-red {        background: #50011a;        color: white;      }    </style>  </head>  <body>    <h3>Grid 4</h3>    <div class="col-3 col-s-6 bg-red">      Satu layar dibagi menjadi 4 bagian, jadi tiap kotak berukuran 3    </div>    <div class="col-3 col-s-6 bg-blue">      Satu layar dibagi menjadi 4 bagian, jadi tiap kotak berukuran 3    </div>    <div class="col-3 col-s-6 bg-green">      Satu layar dibagi menjadi 4 bagian, jadi tiap kotak berukuran 3    </div>    <div class="col-3 col-s-6 bg-red">      Satu layar dibagi menjadi 4 bagian, jadi tiap kotak berukuran 3    </div>    <h3>Grid 3</h3>    <div class="col-4 bg-green">      Satu layar dibagi menjadi 3 bagian, tiap bagian berukuran 4    </div>    <div class="col-4 bg-red">      Satu layar dibagi menjadi 3 bagian, tiap bagian berukuran 4    </div>    <div class="col-4 bg-blue">      Satu layar dibagi menjadi 3 bagian, tiap bagian berukuran 4    </div>    <h3>Grid 2</h3>    <div class="col-6 bg-green">      Satu layar dibagi menjadi 2 bagian, tiap bagian berukuran 6    </div>    <div class="col-6 bg-red">      Satu layar dibagi menjadi 2 bagian, tiap bagian berukuran 6    </div>  </body></html>""";
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
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Stack(
              children: [
                Column(children: [
                  HeaderBackWidget(),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "CSS / Konsep Grid pada Halaman Web",
                      style: TextStyle(
                          color: Color(0xFF244F83),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 236, 236, 236),
                          borderRadius: BorderRadius.circular(10)),
                      child: TabBar(
                        padding: EdgeInsets.zero,
                        labelColor: const Color(0xFF449EDA),
                        unselectedLabelColor: const Color(0xFF424242),
                        controller: tabController,
                        tabs: const [
                          Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: Text(
                              "Materi",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: Text(
                              "Interaktif",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: Text(
                              "Playground",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                        indicator: BoxDecoration(
                            color: const Color(0xFFE2F3FB),
                            borderRadius: borderRadiusTab),
                      ),
                    ),
                  )
                ]),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(controller: tabController, children: [
              Container(
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: const Color(0xFFE2F3FB),
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Konsep grid merupakan sebuah trik untuk membagi lebar layar menjadi 12 bagian. Konsep ini sangat membantu untuk membuat tampilan web menjadi lebih mudah. Berikut ini contoh sintak pembagian grid.",
                                style: TextStyle(fontSize: 12),
                              ),
                              SvgPicture.asset(
                                "assets/img/img_formatgrid.svg",
                                width: MediaQuery.of(context).size.width,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ]),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: const Color(0xFFE2F3FB),
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "TAG",
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Wrap(
                                alignment: WrapAlignment.start,
                                children: [
                                  TagWidget(
                                    title: "grid",
                                    onPressed: (text) {
                                      setState(() {
                                        tag = text;
                                      });
                                      wvcontroller
                                          .loadHtmlString(textExeInteraktif());
                                    },
                                    selected: tag,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "KODE",
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: HighlightView(
                                  textInteraktif(),
                                  language: 'html',
                                  theme: themeMap["a11y-dark"]!,
                                  padding: const EdgeInsets.all(12),
                                  textStyle: const TextStyle(
                                    fontFamily:
                                        'SFMono-Regular,Consolas,Liberation Mono,Menlo,monospace',
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "PRATINJAU",
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white, border: Border.all()),
                                width: MediaQuery.of(context).size.width,
                                height: 300,
                                child: WebViewWidget(
                                  gestureRecognizers: gestureRecognizers,
                                  controller: wvcontroller,
                                ),
                              )
                            ]),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: const Color(0xFFE2F3FB),
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Button(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  text: isedit ? "Simpan" : "Edit",
                                  onPress: () {
                                    if (!isedit) {
                                      codeController.text = codeEditor;
                                    }
                                    setState(() {
                                      if (isedit) {
                                        codeEditor = codeEditorTemp;
                                        if (codeEditor.isEmpty) {
                                          wvcontroller2.loadHtmlString(
                                              """<html></html>""");
                                        } else {
                                          wvcontroller2
                                              .loadHtmlString(codeEditor);
                                        }
                                      }
                                      isedit = !isedit;
                                    });
                                  }),
                              isedit
                                  ? SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: 200,
                                      child: TextField(
                                        controller: codeController,
                                        maxLines: null,
                                        expands: true,
                                        onChanged: (text) {
                                          setState(() {
                                            codeEditorTemp = text;
                                          });
                                        },
                                        keyboardType: TextInputType.multiline,
                                        textAlignVertical:
                                            TextAlignVertical.top,
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            filled: true,
                                            fillColor: Colors.white),
                                      ),
                                    )
                                  : SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          codeEditor.length <= 70 ? 200 : null,
                                      child: HighlightView(
                                        codeEditor,
                                        language: 'html',
                                        theme: themeMap["a11y-dark"]!,
                                        padding: const EdgeInsets.all(12),
                                        textStyle: const TextStyle(
                                          fontFamily:
                                              'SFMono-Regular,Consolas,Liberation Mono,Menlo,monospace',
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white, border: Border.all()),
                                width: MediaQuery.of(context).size.width,
                                height: 300,
                                child: WebViewWidget(
                                    gestureRecognizers: gestureRecognizers,
                                    controller: wvcontroller2),
                              )
                            ]),
                      ),
                    )
                  ],
                ),
              )
            ]),
          )
        ],
      ),
    );
  }
}
