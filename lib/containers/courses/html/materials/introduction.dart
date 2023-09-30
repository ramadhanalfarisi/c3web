import 'dart:convert';

import 'package:c3web/helpers/db_helper.dart';
import 'package:c3web/helpers/image_bytes.dart';
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

class Introduction extends StatefulWidget {
  const Introduction({super.key});

  @override
  State<Introduction> createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  BorderRadiusGeometry borderRadiusTab = const BorderRadius.only(
      topLeft: Radius.circular(10), bottomLeft: Radius.circular(10));
  String tag = 'html';
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
    DbHelper.updateDbMateriProgressHtml(0);
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
          if (tag == "html") {
            DbHelper.updateDbInteraktifProgressHtml(0, 0, 100);
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
    if (tag == "html") {
      return """<!DOCTYPE html>\n<html>\n</html>""";
    } else if (tag == "head") {
      return """<!DOCTYPE html>\n<html>\n  <head>\n    <title> Judul Halaman </title>\n  </head>\n</html>""";
    } else {
      return """<!DOCTYPE html>\n<html>\n  <body> <!-- konten dalam web -->  </body>\n</html>""";
    }
  }

  String textExeInteraktif() {
    if (tag == "html") {
      return r"""<!DOCTYPE html><html></html>""";
    } else if (tag == "head") {
      return r"""<!DOCTYPE html><html>  <head> <title> Judul Halaman </title>  </head></html>""";
    } else {
      return r"""<!DOCTYPE html><html>  <body> <!-- konten dalam web -->  </body></html>""";
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
                      "HTML / Konsep HTML",
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
                            "  HTTP (Hypertext transfer protocol) merupakan protokol yang digunakan untuk mentransfer data antara web server ke web browser. Protocol ini mentransfer dokumen-dokumen web yang ditulis atau berformat HTML (Hypertext Markup Language). Dikatakan markup language karena HTML berfungsi untuk ‘memperindah’ file teks biasa untuk ditampilkan pada program web browser hal ini dilakukan dengan menambahkan elemen atu sering disebut sebagai tag-tag pada file teks biasa tersebut.",
                            style: TextStyle(fontSize: 12),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            "  Tag HTML biasanya berupa tag-tag yang berpasangan dan ditandai dengan symbol lebih besar (). Pasangan dari sebuah tag ditandai dengan symbol garis miring (/). Misalnya pasangan dari tag adalah. Dalam hal ini kita sebut sebagai elemen dan biasanya dalam suatu elemen terdapat atributatribut untuk mengatur elemen itu.",
                            style: TextStyle(fontSize: 12),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            width: MediaQuery.of(context).size.width,
                            child: HighlightView(
                              """<tag atribut = “value”>…</tag>.""",
                              language: 'html',
                              theme: themeMap["a11y-dark"]!,
                              padding: const EdgeInsets.all(12),
                              textStyle: const TextStyle(
                                fontFamily:
                                    'SFMono-Regular,Consolas,Liberation Mono,Menlo,monospace',
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const Text(
                            "  Dalam penulisan tag HTML tidaklah case sensitive artinya pengguna huruf kecil ataupun capital tidaklah menjadi masalah.",
                            style: TextStyle(fontSize: 12),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Image.memory(
                              base64.decode(ImageBytes.imgIntroducing)),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "  Struktur file HTML diawali dengan sebuah tag <html> dan ditutup dengan tag </html>. Di dalam tag ini terdapat dua buah bagian besar, yaitu yang diapit oleh tag <head>…</head> dan tag <body>…</body>.",
                            style: TextStyle(fontSize: 12),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            "  Bagian yang diapit oleh tag HEAD merupakan header dari halaman HTML dan tidak ditampilkan pada browser. Bagian ini berisi tag-tag header seperti <title>…</title> yang berfungsi untuk mengeluarkan judul pada tittle bar window web browser. Bagian kedua, yang diapit oleh tag BODY merupakan bagian yang akan ditampilkan pada halaman web browser nantinya. Pada bagian ini anada akan menuliskan semua jenis informasi berupa teks dengan bermacam format maupun gambar yang ingin sampaikan pada pengguna nantinya.",
                            style: TextStyle(fontSize: 12),
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
                                    title: "html",
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
                                    title: "head",
                                    onPressed: (text) {
                                      DbHelper.updateDbInteraktifProgressHtml(
                                          0, 1, 100);
                                      setState(() {
                                        tag = text;
                                        wvcontroller.loadHtmlString(
                                            textExeInteraktif());
                                      });
                                    },
                                    selected: tag,
                                  ),
                                  TagWidget(
                                    title: "body",
                                    onPressed: (text) {
                                      DbHelper.updateDbInteraktifProgressHtml(
                                          0, 2, 100);
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
