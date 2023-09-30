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

class FormatText extends StatefulWidget {
  const FormatText({super.key});

  @override
  State<FormatText> createState() => _FormatTextState();
}

class _FormatTextState extends State<FormatText>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  BorderRadiusGeometry borderRadiusTab = const BorderRadius.only(
      topLeft: Radius.circular(10), bottomLeft: Radius.circular(10));
  String tag = 'b';
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
    DbHelper.updateDbMateriProgressHtml(1);
    wvcontroller = WebViewController.fromPlatformCreationParams(params);
    wvcontroller2 = WebViewController.fromPlatformCreationParams(params);
    wvcontroller.enableZoom(true);
    wvcontroller2.enableZoom(true);
    wvcontroller.loadHtmlString(textExeInteraktif());
    wvcontroller2.loadHtmlString("""<html></html>""");
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
          if (tag == "b") {
            DbHelper.updateDbInteraktifProgressHtml(1, 0, 100);
          }
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
    if (tag == "b") {
      return """<!DOCTYPE html>\n<html>\n  <head>\n    <title> Format Teks HTML </title>\n  </head>\n  <body>\n    <b> teks tebal </b>\n  </body>\n</html>""";
    } else if (tag == "i") {
      return """<!DOCTYPE html>\n<html>\n  <head>\n    <title> Format Teks HTML </title>\n  </head>\n  <body>\n    <i> teks miring </i>\n  </body>\n</html>""";
    } else if (tag == "u") {
      return """<!DOCTYPE html>\n<html>\n  <head>\n    <title> Format Teks HTML </title>\n  </head>\n  <body>\n    <u> teks garis bawah </u>\n  </body>\n</html>""";
    } else if (tag == "sup") {
      return """<!DOCTYPE html>\n<html>\n  <head>\n    <title> Format Teks HTML </title>\n  </head>\n  <body>\n    <sup> teks eksponen </sup>\n  </body>\n</html>""";
    } else if (tag == "sub") {
      return """<!DOCTYPE html>\n<html>\n  <head>\n    <title> Format Teks HTML </title>\n  </head>\n  <body>\n    <sub> teks dibawh garis </sub>\n  </body>\n</html>""";
    } else if (tag == "del") {
      return """<!DOCTYPE html>\n<html>\n  <head>\n    <title> Format Teks HTML </title>\n  </head>\n  <body>\n    <del> teks dicoret </del>\n  </body>\n</html>""";
    } else if (tag == "mark") {
      return """<!DOCTYPE html>\n<html>\n  <head>\n    <title> Format Teks HTML </title>\n  </head>\n  <body>\n    <mark> teks highlight </mark>\n  </body>\n</html>""";
    } else if (tag == "h1") {
      return """<!DOCTYPE html>\n<html>\n  <head>\n    <title> Format Teks HTML </title>\n  </head>\n  <body>\n    <h1> teks heading 1 </h1>\n  </body>\n</html>""";
    } else if (tag == "h2") {
      return """<!DOCTYPE html>\n<html>\n  <head>\n    <title> Format Teks HTML </title>\n  </head>\n  <body>\n    <h2> teks heading 2 </h2>\n  </body>\n</html>""";
    } else if (tag == "h3") {
      return """<!DOCTYPE html>\n<html>\n  <head>\n    <title> Format Teks HTML </title>\n  </head>\n  <body>\n    <h3> teks heading 3 </h3>\n  </body>\n</html>""";
    } else if (tag == "h4") {
      return """<!DOCTYPE html>\n<html>\n  <head>\n    <title> Format Teks HTML </title>\n  </head>\n  <body>\n    <h4> teks heading 4 </h4>\n  </body>\n</html>""";
    } else if (tag == "h5") {
      return """<!DOCTYPE html>\n<html>\n  <head>\n    <title> Format Teks HTML </title>\n  </head>\n  <body>\n    <h5> teks heading 5 </h5>\n  </body>\n</html>""";
    } else if (tag == "h6") {
      return """<!DOCTYPE html>\n<html>\n  <head>\n    <title> Format Teks HTML </title>\n  </head>\n  <body>\n    <h6> teks heading 6 </h6>\n  </body>\n</html>""";
    } else {
      return """<!DOCTYPE html>\n<html>\n  <head>\n    <title> Format Teks HTML </title>\n  </head>\n  <body>\n    <p> paragraf </p>\n  </body>\n</html>""";
    }
  }

  String textExeInteraktif() {
    if (tag == "b") {
      return r"""<!DOCTYPE html><html>  <head>    <title> Format Teks HTML </title>  </head>    <body> <b> teks tebal </b> </body></html>""";
    } else if (tag == "i") {
      return r"""<!DOCTYPE html><html>  <head>    <title> Format Teks HTML </title>  </head>    <body> <i> teks miring </i> </body></html>""";
    } else if (tag == "u") {
      return r"""<!DOCTYPE html><html>  <head>    <title> Format Teks HTML </title>  </head>    <body> <u> teks garis bawah </u>  </body></html>""";
    } else if (tag == "sup") {
      return r"""<!DOCTYPE html><html>  <head>    <title> Format Teks HTML </title>  </head>    <body> <sup> teks eksponen </sup>  </body></html>""";
    } else if (tag == "sub") {
      return r"""<!DOCTYPE html><html>  <head>    <title> Format Teks HTML </title>  </head>    <body> <sub> teks dibawh garis </sub> </body></html>""";
    } else if (tag == "del") {
      return r"""<!DOCTYPE html><html>  <head>    <title> Format Teks HTML </title>  </head>    <body> <del> teks dicoret </del>  </body></html>""";
    } else if (tag == "mark") {
      return r"""<!DOCTYPE html><html>  <head>    <title> Format Teks HTML </title>  </head>    <body> <mark> teks highlight </mark>  </body></html>""";
    } else if (tag == "h1") {
      return r"""<!DOCTYPE html><html>  <head>    <title> Format Teks HTML </title>  </head>    <body> <h1> teks heading 1 </h1>  </body></html>""";
    } else if (tag == "h2") {
      return r"""<!DOCTYPE html><html>  <head>    <title> Format Teks HTML </title>  </head>    <body> <h2> teks heading 2 </h2>  </body></html>""";
    } else if (tag == "h3") {
      return r"""<!DOCTYPE html><html>  <head>    <title> Format Teks HTML </title>  </head>    <body> <h3> teks heading 3 </h3>  </body></html>""";
    } else if (tag == "h4") {
      return r"""<!DOCTYPE html><html>  <head>    <title> Format Teks HTML </title>  </head>    <body> <h4> teks heading 4 </h4>  </body></html>""";
    } else if (tag == "h5") {
      return r"""<!DOCTYPE html><html>  <head>    <title> Format Teks HTML </title>  </head>    <body> <h5> teks heading 5 </h5>  </body></html>""";
    } else if (tag == "h6") {
      return r"""<!DOCTYPE html><html>  <head>    <title> Format Teks HTML </title>  </head>    <body> <h6> teks heading 6 </h6>  </body></html>""";
    } else {
      return r"""<!DOCTYPE html><html>  <head>    <title> Format Teks HTML </title>  </head>    <body> <p> paragraf </p>  </body></html>""";
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
                      "HTML / Format teks HTML",
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
                        child: Column(children: [
                          const Text(
                            "  Pada HTML 5 menyediakan beberapa tag yang digunakan untuk membuat berbagai macam format teks pada halaman web, yaitu sebagai berikut.",
                            style: TextStyle(fontSize: 12),
                          ),
                          SvgPicture.asset(
                            "assets/img/img_formattxt.svg",
                            width: MediaQuery.of(context).size.width,
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
                                    title: "b",
                                    onPressed: (text) {
                                      setState(() {
                                        tag = text;
                                        wvcontroller.loadHtmlString(
                                            textExeInteraktif());
                                      });
                                    },
                                    selected: tag,
                                  ),
                                  TagWidget(
                                    title: "i",
                                    onPressed: (text) {
                                      DbHelper.updateDbInteraktifProgressHtml(
                                          1, 1, 100);
                                      setState(() {
                                        tag = text;
                                        wvcontroller.loadHtmlString(
                                            textExeInteraktif());
                                      });
                                    },
                                    selected: tag,
                                  ),
                                  TagWidget(
                                    title: "u",
                                    onPressed: (text) {
                                      DbHelper.updateDbInteraktifProgressHtml(
                                          1, 2, 100);
                                      setState(() {
                                        tag = text;
                                        wvcontroller.loadHtmlString(
                                            textExeInteraktif());
                                      });
                                    },
                                    selected: tag,
                                  ),
                                  TagWidget(
                                    title: "sup",
                                    onPressed: (text) {
                                      DbHelper.updateDbInteraktifProgressHtml(
                                          1, 3, 100);
                                      setState(() {
                                        tag = text;
                                        wvcontroller.loadHtmlString(
                                            textExeInteraktif());
                                      });
                                    },
                                    selected: tag,
                                  ),
                                  TagWidget(
                                    title: "sub",
                                    onPressed: (text) {
                                      DbHelper.updateDbInteraktifProgressHtml(
                                          1, 4, 100);
                                      setState(() {
                                        tag = text;
                                        wvcontroller.loadHtmlString(
                                            textExeInteraktif());
                                      });
                                    },
                                    selected: tag,
                                  ),
                                  TagWidget(
                                    title: "del",
                                    onPressed: (text) {
                                      DbHelper.updateDbInteraktifProgressHtml(
                                          1, 5, 100);
                                      setState(() {
                                        tag = text;
                                        wvcontroller.loadHtmlString(
                                            textExeInteraktif());
                                      });
                                    },
                                    selected: tag,
                                  ),
                                  TagWidget(
                                    title: "mark",
                                    onPressed: (text) {
                                      DbHelper.updateDbInteraktifProgressHtml(
                                          1, 6, 100);
                                      setState(() {
                                        tag = text;
                                        wvcontroller.loadHtmlString(
                                            textExeInteraktif());
                                      });
                                    },
                                    selected: tag,
                                  ),
                                  TagWidget(
                                    title: "h1",
                                    onPressed: (text) {
                                      DbHelper.updateDbInteraktifProgressHtml(
                                          1, 7, 100);
                                      setState(() {
                                        tag = text;
                                        wvcontroller.loadHtmlString(
                                            textExeInteraktif());
                                      });
                                    },
                                    selected: tag,
                                  ),
                                  TagWidget(
                                    title: "h2",
                                    onPressed: (text) {
                                      DbHelper.updateDbInteraktifProgressHtml(
                                          1, 8, 100);
                                      setState(() {
                                        tag = text;
                                        wvcontroller.loadHtmlString(
                                            textExeInteraktif());
                                      });
                                    },
                                    selected: tag,
                                  ),
                                  TagWidget(
                                    title: "h3",
                                    onPressed: (text) {
                                      DbHelper.updateDbInteraktifProgressHtml(
                                          1, 9, 100);
                                      setState(() {
                                        tag = text;
                                        wvcontroller.loadHtmlString(
                                            textExeInteraktif());
                                      });
                                    },
                                    selected: tag,
                                  ),
                                  TagWidget(
                                    title: "h4",
                                    onPressed: (text) {
                                      DbHelper.updateDbInteraktifProgressHtml(
                                          1, 10, 100);
                                      setState(() {
                                        tag = text;
                                        wvcontroller.loadHtmlString(
                                            textExeInteraktif());
                                      });
                                    },
                                    selected: tag,
                                  ),
                                  TagWidget(
                                    title: "h5",
                                    onPressed: (text) {
                                      DbHelper.updateDbInteraktifProgressHtml(
                                          1, 11, 100);
                                      setState(() {
                                        tag = text;
                                        wvcontroller.loadHtmlString(
                                            textExeInteraktif());
                                      });
                                    },
                                    selected: tag,
                                  ),
                                  TagWidget(
                                    title: "h6",
                                    onPressed: (text) {
                                      DbHelper.updateDbInteraktifProgressHtml(
                                          1, 12, 100);
                                      setState(() {
                                        tag = text;
                                        wvcontroller.loadHtmlString(
                                            textExeInteraktif());
                                      });
                                    },
                                    selected: tag,
                                  ),
                                  TagWidget(
                                    title: "p",
                                    onPressed: (text) {
                                      DbHelper.updateDbInteraktifProgressHtml(
                                          1, 13, 100);
                                      setState(() {
                                        tag = text;
                                        wvcontroller.loadHtmlString(
                                            textExeInteraktif());
                                      });
                                    },
                                    selected: tag,
                                  )
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
                                    controller: wvcontroller),
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
