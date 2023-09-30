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

class FormatTextCSS extends StatefulWidget {
  const FormatTextCSS({super.key});

  @override
  State<FormatTextCSS> createState() => _FormatTextCSSState();
}

class _FormatTextCSSState extends State<FormatTextCSS>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  BorderRadiusGeometry borderRadiusTab = const BorderRadius.only(
      topLeft: Radius.circular(10), bottomLeft: Radius.circular(10));
  String tag = 'text-color';
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
    DbHelper.updateDbMateriProgressCss(3);
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
          if (tag == "text-color") {
            DbHelper.updateDbInteraktifProgressCss(3, 0, 100);
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
    if (tag == "text-color") {
      return """<html>\n    <style media="screen">\n        .maroon { color: #820004; }\n        .navy { color: #05004c; }\n        .indigo {color: #5D76CB; }\n    </style>\n<body>\n    <fieldset>\n      <legend>Text Color</legend>\n      <p class="maroon">Ini warna maroon</p>\n      <p class="navy">Ini warna navy</p>\n      <p class="indigo">Ini warna indigo</p>\n    </fieldset>\n  </body>    \n</html>""";
    } else if (tag == "letter-spacing") {
      return """<html>\n    <style media="screen">\n        .spacing{ letter-spacing: 2px; word-spacing: 5px; line-height: 20px;\n          /* silahkan berkreasi dengan merubah value dari setiap properi */\n        }\n    </style>\n<body>\n    <fieldset>\n      <legend>Spacing</legend>\n      <p class="spacing">\n        It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is\n        that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop\n        publishing packages and web page editors now use Lorem Ipsum as their default modeltext, and a search for 'lorem ipsum' will uncover many web sites still in their infancy.\n        Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).\n      </p>\n    </fieldset>\n  </body>    \n</html>""";
    } else if (tag == "text-transform") {
      return """<html>\n    <style media="screen">\n        .uppercase{ text-transform:uppercase; }\n        .lowercase{ text-transform:lowercase; }\n        .capitalize{ text-transform:capitalize; }\n    </style>\n<body>\n    <fieldset>\n      <legend>Transform</legend>\n      <p class="uppercase">ini adalah contoh transform uppercase.</p>\n      <p class="lowercase">ini adalah contoh transform lowercase.</p>\n      <p class="capitalize">ini adalah contoh transform capitalized.</p>\n    </fieldset>\n  </body>    \n</html>""";
    } else {
      return """<html>\n    <style media="screen">\n        .paragraf{\n          font-family: "Courier New";\n          font-size: 20px;\n        }\n        ul{\n          list-style-type:circle;\n        }\n        li{\n          font-family: "Tahoma";\n          font-size: 15px;\n        }\n    </style>\n<body>\n    <fieldset>\n      <legend>Font Style</legend>\n      <p class="paragraf">\n        CSS dapat mengatur style dari teks yang ada pada halaman web yang dibuat.\n        Terdapat beberapa property yang dapat digunakan untuk mengatur style teks yaitu sebagai berikut.\n        <ul>\n          <li>text-align: digunakan untuk mengatur perataan teks, value yang dapat digunakan yaitu left, center, right.</li>\n          <li>color: digunakan untuk memberikan warna pada teks.</li>\n          <li>letter-spacing: mengatur jarak antar karakter.</li>\n          <li>word-spacing: mengatur jarak antar kata.</li>\n        </ul>\n      </p>\n    </fieldset>\n  </body>    \n</html>""";
    }
  }

  String textExeInteraktif() {
    if (tag == "text-color") {
      return """<html>    <style media="screen">        .maroon { color: #820004; }        .navy { color: #05004c; }        .indigo {color: #5D76CB; }    </style><body>    <fieldset>      <legend>Text Color</legend>      <p class="maroon">Ini warna maroon</p>      <p class="navy">Ini warna navy</p>      <p class="indigo">Ini warna indigo</p>    </fieldset>  </body>    </html>""";
    } else if (tag == "letter-spacing") {
      return """<html>    <style media="screen">        .spacing{ letter-spacing: 2px; word-spacing: 5px; line-height: 20px;          /* silahkan berkreasi dengan merubah value dari setiap properi */        }    </style><body>    <fieldset>      <legend>Spacing</legend>      <p class="spacing">        It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is        that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop        publishing packages and web page editors now use Lorem Ipsum as their default modeltext, and a search for 'lorem ipsum' will uncover many web sites still in their infancy.        Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).      </p>    </fieldset>  </body>    </html>""";
    } else if (tag == "text-transform") {
      return """<html>    <style media="screen">        .uppercase{ text-transform:uppercase; }        .lowercase{ text-transform:lowercase; }        .capitalize{ text-transform:capitalize; }    </style><body>    <fieldset>      <legend>Transform</legend>      <p class="uppercase">ini adalah contoh transform uppercase.</p>      <p class="lowercase">ini adalah contoh transform lowercase.</p>      <p class="capitalize">ini adalah contoh transform capitalized.</p>    </fieldset>  </body>    </html>""";
    } else {
      return """<html>    <style media="screen">        .paragraf{          font-family: "Courier New";          font-size: 20px;        }        ul{          list-style-type:circle;        }        li{          font-family: "Tahoma";          font-size: 15px;        }    </style><body>    <fieldset>      <legend>Font Style</legend>      <p class="paragraf">        CSS dapat mengatur style dari teks yang ada pada halaman web yang dibuat.        Terdapat beberapa property yang dapat digunakan untuk mengatur style teks yaitu sebagai berikut.        <ul>          <li>text-align: digunakan untuk mengatur perataan teks, value yang dapat digunakan yaitu left, center, right.</li>          <li>color: digunakan untuk memberikan warna pada teks.</li>          <li>letter-spacing: mengatur jarak antar karakter.</li>          <li>word-spacing: mengatur jarak antar kata.</li>        </ul>      </p>    </fieldset>  </body>    </html>""";
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
                      "CSS / CSS Text",
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
                        child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                """CSS dapat mengatur style dari teks yang ada pada halaman web yang dibuat. Terdapat beberapa property yang dapat digunakan untuk mengatur style teks yaitu sebagai berikut.
●	text-align, digunakan untuk mengatur perataan teks, value yang dapat digunakan yaitu left, center, right.
●	color, digunakan untuk memberikan warna pada teks.
●	letter-spacing, mengatur jarak antar karakter.
●	word-spacing, mengatur jarak antar kata.
●	line-height, mengatur jarak antara baris satu dengan baris lainnya.
●	font-size, mengatur ukuran font.
●	font-family, mengatur jenis font.
●	font-style, mengatur style pada teks dengan value (normal, italic)
●	font-weight, mengatur ketebalan font.
""",
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(
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
                                    title: "text-color",
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
                                    title: "letter-spacing",
                                    onPressed: (text) {
                                      DbHelper.updateDbInteraktifProgressCss(
                                          3, 1, 100);
                                      setState(() {
                                        tag = text;
                                      });
                                      wvcontroller
                                          .loadHtmlString(textExeInteraktif());
                                    },
                                    selected: tag,
                                  ),
                                  TagWidget(
                                    title: "text-transform",
                                    onPressed: (text) {
                                      DbHelper.updateDbInteraktifProgressCss(
                                          3, 2, 100);
                                      setState(() {
                                        tag = text;
                                      });
                                      wvcontroller
                                          .loadHtmlString(textExeInteraktif());
                                    },
                                    selected: tag,
                                  ),
                                  TagWidget(
                                    title: "font-style",
                                    onPressed: (text) {
                                      DbHelper.updateDbInteraktifProgressCss(
                                          3, 3, 100);
                                      setState(() {
                                        tag = text;
                                      });
                                      wvcontroller
                                          .loadHtmlString(textExeInteraktif());
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
