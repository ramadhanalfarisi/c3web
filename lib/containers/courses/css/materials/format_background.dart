import 'package:c3web/helpers/db_helper.dart';
import 'package:c3web/widgets/courses/tag.dart';
import 'package:c3web/widgets/templates/button.dart';
import 'package:c3web/widgets/templates/header_back.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/theme_map.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class FormatBackground extends StatefulWidget {
  const FormatBackground({super.key});

  @override
  State<FormatBackground> createState() => _FormatBackgroundState();
}

class _FormatBackgroundState extends State<FormatBackground>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  BorderRadiusGeometry borderRadiusTab = const BorderRadius.only(
      topLeft: Radius.circular(10), bottomLeft: Radius.circular(10));
  String tag = 'background-color';
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
    DbHelper.updateDbMateriProgressCss(1);
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
          if (tag == "background-color") {
            DbHelper.updateDbInteraktifProgressCss(1, 0, 100);
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
    if (tag == "background-color") {
      return """<html>\n  <style media="screen">\n    div {\n      width: 80%;\n      margin: 0 auto;\n      height: 100px;\n    }\n    .bgcolor{ background-color: #ff4533; }\n  </style>\n  <body>\n    <div class="bgcolor">\n      <h1 align="center">Background Color</h1>\n    </div>\n  </body>\n</html>""";
    } else if (tag == "background-image") {
      return """<html>\n  <style media="screen">\n    div {\n      width: 80%;\n      margin: 0 auto;\n      height: 100px;\n    }\n    .bgimage{ background-image: url("assets/img/background.jpg"); }\n  </style>\n  <body>\n    <div class="bgimage">\n      <h1 align="center">Background Color</h1>\n    </div>\n  </body>\n</html>""";
    } else if (tag == "background-gradient") {
      return """<html>\n  <style media="screen">\n    div {\n      width: 80%;\n      margin: 0 auto;\n      height: 100px;\n    }\n    .gradient1{ background:linear-gradient(to right, red, yellow, green);}\n  </style>\n  <body>\n    <div class="gradient1">\n      <h1 align="center">Background Color</h1>\n    </div>\n  </body>\n</html>""";
    } else {
      return """<html>\n  <style media="screen">\n    div {\n      width: 80%;\n      margin: 0 auto;\n      height: 100px;\n    }\n    .bgposition{\n  height: 350px;\n  background: url("assets/img/bunny.jpg") #820004 no-repeat left;\n}\n  </style>\n  <body>\n    <div class="bgposition">\n      <h1 align="center">Background Color</h1>\n    </div>\n  </body>\n</html>""";
    }
  }

  String textExeInteraktif() {
    if (tag == "background-color") {
      return """<html>  <style media="screen">    div {      width: 80%;      margin: 0 auto;      height: 100px;    }    .bgcolor{ background-color: #ff4533; }  </style>  <body>    <div class="bgcolor">      <h1 align="center">Background Color</h1>    </div>  </body></html>""";
    } else if (tag == "background-image") {
      return """<html>  <style media="screen">    div {      width: 80%;      margin: 0 auto;      height: 100px;    }    .bgimage{ background-image: url("https://drive.google.com/uc?export=view&id=125ulPOGmVMR3q5tzTytyZ6VeHV6TPaaB"); }  </style>  <body>    <div class="bgimage">      <h1 align="center">Background Color</h1>    </div>  </body></html>""";
    } else if (tag == "background-gradient") {
      return """<html>  <style media="screen">    div {      width: 80%;      margin: 0 auto;      height: 100px;    }    .gradient1{ background:linear-gradient(to right, red, yellow, green);}  </style>  <body>    <div class="gradient1">      <h1 align="center">Background Color</h1>    </div>  </body></html>""";
    } else {
      return """<html>  <style media="screen">    div {      width: 80%;      margin: 0 auto;      height: 100px;    }    .bgposition{  height: 350px;  background: url("https://images.pexels.com/photos/326012/pexels-photo-326012.jpeg") #820004 no-repeat left;}  </style>  <body>    <div class="bgposition">      <h1 align="center">Background Color</h1>    </div>  </body></html>""";
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
                      "CSS / Pengenalan CSS",
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
                                "  CSS (Cascading Style Sheet) merupakan sekumpulan kode yang digunakan untuk mempercantik atau styling halaman web yang termuat pada komonen atau tag yang membentuk sebuah web. Struktur penulisan sintak CSS adalah sebagai berikut",
                                style: TextStyle(fontSize: 12),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: HighlightView(
                                    """selector {
 property: value
}""",
                                    language: "css",
                                  )),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                """Keterangan:
-	Selector: merupakan nama komponen / objek yang akan diberikan style. Selector ini dapat berupa nama tag pada HTML, id tag HTML, atau nama class pada sebuah tag HTML. 

▪	Untuk penulisan selector dengan tag, dapat dituliskan dengan nama tag HTML secara langsung, contoh p, img, h1, dan lain-lain.
▪	Untuk penulisan selector dengan nama class, dapat dituliskan dengan diawali tanda titik (.) diikuti dengan nama classnya.
▪	Untuk penulisan selector dengan nama id, dapat dituliskan dengan diawali tanda pagar (#) diikuti dengan nama id-nya.

Contoh: <p class = ”paragraf” id=”paragraf1”> …. </p>
Penulisan Selector p atau .paragraf atau #paragraf

-	Property: merupakan bagian dari selector yang akan kita ubah.

-	Value: merupakan nilai dari property.

Contoh :
""",
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: HighlightView(
                                    """h1 {
 background-color: lime;
 text-align: center;
}""",
                                    language: "css",
                                  )),
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
                                    title: "background-color",
                                    onPressed: (text) {
                                      setState(() {
                                        tag = text;
                                      });
                                      wvcontroller
                                          .loadHtmlString(textExeInteraktif());
                                    },
                                    selected: tag,
                                  ),
                                  TagWidget(
                                    title: "background-image",
                                    onPressed: (text) {
                                      DbHelper.updateDbInteraktifProgressCss(
                                          1, 1, 100);
                                      setState(() {
                                        tag = text;
                                      });
                                      wvcontroller
                                          .loadHtmlString(textExeInteraktif());
                                    },
                                    selected: tag,
                                  ),
                                  TagWidget(
                                    title: "background-gradient",
                                    onPressed: (text) {
                                      DbHelper.updateDbInteraktifProgressCss(
                                          1, 2, 100);
                                      setState(() {
                                        tag = text;
                                      });
                                      wvcontroller
                                          .loadHtmlString(textExeInteraktif());
                                    },
                                    selected: tag,
                                  ),
                                  TagWidget(
                                    title: "background-position",
                                    onPressed: (text) {
                                      DbHelper.updateDbInteraktifProgressCss(
                                          1, 3, 100);
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
