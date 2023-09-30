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

class FormatList extends StatefulWidget {
  const FormatList({super.key});

  @override
  State<FormatList> createState() => _FormatListState();
}

class _FormatListState extends State<FormatList>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  BorderRadiusGeometry borderRadiusTab = const BorderRadius.only(
      topLeft: Radius.circular(10), bottomLeft: Radius.circular(10));
  String tag = 'ol';
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
    DbHelper.updateDbMateriProgressHtml(2);
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
          if (tag == "ol") {
            DbHelper.updateDbInteraktifProgressHtml(2, 0, 100);
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
    if (tag == "ol") {
      return """<!DOCTYPE html>\n<html>\n  <head>\n    <title> Format Teks HTML </title>\n  </head>\n  <body>\n    <h2>Latihan Membuat Format Teks</h2>\n    <ol>\n      <!-- Format Tebal  -->\n      <li>\n        <b>Ini adalah Format Tebal</b>\n      </li>\n      <!-- Format Miring  -->\n      <li>\n        <i>Ini adalah Format Miring</i>\n      </li>\n      <!-- Format Garis Bawah  -->\n      <li>\n        <u>Ini adalah Format Garis Bawah</u>\n      </li>\n      <!-- Format Superscript Text  -->\n      <li>\n        Ini adalah format pangkat x<sup>2</sup> + y <sup>3</sup> = 15\n      </li>\n      <!-- Format Subscript Text  -->\n      <li>\n        H<sub>2</sub>O<sub>3</sub>\n      </li>\n      <!-- Format Highligh  -->\n      <li>\n        <mark>Coding itu mudah</mark>\n      </li>\n      <!-- Format Coret  -->\n      <li>\n        Pemrograman Web itu <del>sulit</del> mudah\n      </li>\n    </ol>\n  </body>\n</html>""";
    } else {
      return """<!DOCTYPE html>\n<html>\n  <head>\n    <title> Format Teks HTML </title>\n  </head>\n  <body>\n    <h2>Latihan Membuat Format Teks</h2>\n    <ul>\n      <!-- Format Tebal  -->\n      <li>\n        <b>Ini adalah Format Tebal</b>\n      </li>\n      <!-- Format Miring  -->\n      <li>\n        <i>Ini adalah Format Miring</i>\n      </li>\n      <!-- Format Garis Bawah  -->\n      <li>\n        <u>Ini adalah Format Garis Bawah</u>\n      </li>\n      <!-- Format Superscript Text  -->\n      <li>\n        Ini adalah format pangkat x<sup>2</sup> + y <sup>3</sup> = 15\n      </li>\n      <!-- Format Subscript Text  -->\n      <li>\n        H<sub>2</sub>O<sub>3</sub>\n      </li>\n      <!-- Format Highligh  -->\n      <li>\n        <mark>Coding itu mudah</mark>\n      </li>\n      <!-- Format Coret  -->\n      <li>\n        Pemrograman Web itu <del>sulit</del> mudah\n      </li>\n    </ul>\n  </body>\n</html>""";
    }
  }

  String textExeInteraktif() {
    if (tag == "ol") {
      return r"""<!DOCTYPE html><html>  <head>    <title> Format Teks HTML </title>  </head>  <body>    <h2>Latihan Membuat Format Teks</h2>    <ol>      <!-- Format Tebal  -->      <li>        <b>Ini adalah Format Tebal</b>      </li>      <!-- Format Miring  -->      <li>        <i>Ini adalah Format Miring</i>      </li>      <!-- Format Garis Bawah  -->      <li>        <u>Ini adalah Format Garis Bawah</u>      </li>      <!-- Format Superscript Text  -->      <li>        Ini adalah format pangkat x<sup>2</sup> + y <sup>3</sup> = 15      </li>      <!-- Format Subscript Text  -->      <li>        H<sub>2</sub>O<sub>3</sub>      </li>      <!-- Format Highligh  -->      <li>        <mark>Coding itu mudah</mark>      </li>      <!-- Format Coret  -->      <li>        Pemrograman Web itu <del>sulit</del> mudah      </li>    </ol>  </body></html>""";
    } else {
      return r"""<!DOCTYPE html><html>  <head>    <title> Format Teks HTML </title>  </head>  <body>    <h2>Latihan Membuat Format Teks</h2>    <ul>      <!-- Format Tebal  -->      <li>        <b>Ini adalah Format Tebal</b>      </li>      <!-- Format Miring  -->      <li>        <i>Ini adalah Format Miring</i>      </li>      <!-- Format Garis Bawah  -->      <li>        <u>Ini adalah Format Garis Bawah</u>      </li>      <!-- Format Superscript Text  -->      <li>        Ini adalah format pangkat x<sup>2</sup> + y <sup>3</sup> = 15      </li>      <!-- Format Subscript Text  -->      <li>        H<sub>2</sub>O<sub>3</sub>      </li>      <!-- Format Highligh  -->      <li>        <mark>Coding itu mudah</mark>      </li>      <!-- Format Coret  -->      <li>        Pemrograman Web itu <del>sulit</del> mudah      </li>    </ul>  </body></html>""";
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
                      "HTML / Format list pada HTML",
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
                            "  List adalah bagian teks di dalam dokumen yang berisi daftar item dari suatu kelompok atau grup tertentu. Sebagai contoh, dalam situs web yang bertema kuliner, list dapat berupa daftar dari makanan dan minuman, beserta harganya. List dapat juga berupa prosedur (urutan langkah-langkah) dari suatu pekerjaan tertentu, yang sifatnya harus dilakukan secara berurutan dari langkah pertama sampai langkah terakhir. Terdapat 2 tipe list pada HTML yaitu ordered list (daftar berurutan) dan unordered list (daftar tak berurutan).",
                            style: TextStyle(fontSize: 12),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            "  Ordered List pada halaman web dapat menggunakan tag <ol></ol> dengan mempunyai tipe list berikut ini.",
                            style: TextStyle(fontSize: 12),
                          ),
                          SvgPicture.asset(
                            "assets/img/img_formatlist1.svg",
                            width: MediaQuery.of(context).size.width,
                          ),
                          const Text(
                            "  Unordered List pada halaman web dapat menggunakan tag <ul></ul> dengan mempunyai tipe list berikut ini.",
                            style: TextStyle(fontSize: 12),
                          ),
                          SvgPicture.asset(
                            "assets/img/img_formatlist2.svg",
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
                                    title: "ol",
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
                                    title: "ul",
                                    onPressed: (text) {
                                      DbHelper.updateDbInteraktifProgressHtml(
                                          2, 1, 100);
                                      setState(() {
                                        tag = text;
                                        wvcontroller.loadHtmlString(
                                            textExeInteraktif());
                                      });
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
