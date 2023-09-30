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

class Multimedia extends StatefulWidget {
  const Multimedia({super.key});

  @override
  State<Multimedia> createState() => _MultimediaState();
}

class _MultimediaState extends State<Multimedia>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  BorderRadiusGeometry borderRadiusTab = const BorderRadius.only(
      topLeft: Radius.circular(10), bottomLeft: Radius.circular(10));
  String tag = 'img';
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
    DbHelper.updateDbMateriProgressHtml(4);
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
          if (tag == "img") {
            DbHelper.updateDbInteraktifProgressHtml(4, 0, 100);
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
    if (tag == "img") {
      return """<!DOCTYPE html>\n<html>\n  <head>\n    <title>Menampilkan Gambar pada HTML</title>\n  </head>\n  <body>\n    <h3>Single Picture</h3>\n    <img src="assets/img/bunny.jpg" width="200" height="200" alt="SMK Telkom Malang">\n  \n    <h3>Picture with text</h3>\n    <img src="assets/img/bunny.jpg" width="70" height="80" align="left"\n    hspace="20" vspace="20" alt="SMK Telkom Malang">\n    Lorem Ipsum is simply dummy text of the printing and typesetting industry.\n    Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,\n    when an unknown printer took a galley of type and scrambled it to make a type specimen book.\n    It has survived not only five centuries, but also the leap into electronic typesetting,\n    remaining essentially unchanged. It was popularised in the 1960s with the release of\n    Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing\n    software like Aldus PageMaker including versions of Lorem Ipsum.\n  </body>\n</html>\n""";
    } else if (tag == "video") {
      return """<!DOCTYPE html>\n<html>\n  <head>\n    <title>Multimedia</title>\n  </head>\n  <body>\n    <h3>Video</h3>\n    <video controls>\n      <source src="assets/video/bunny.mp4" type="video/mp4">\n    </video>\n  </body>\n</html>""";
    } else {
      return """<!DOCTYPE html>\n<html>\n  <head>\n    <title>Multimedia</title>\n  </head>\n  <body>\n    <h3>Audio</h3>\n    <audio controls>\n      <source src="assets/audio/klakson.mp3" type="audio/mp3">\n        Browser doesn't support audio\n        <!--\n        "controls" digunakan untuk menampilkan control audio (play/pause, volume)\n        pastikan file audio sudah terdapat pada folder yang sama dengan file html\n        kalimat "Browser...." ditampilkan jika browser tidak support audio -->\n    </audio>\n  </body>\n</html>""";
    }
  }

  String textExeInteraktif() {
    if (tag == "img") {
      return """<!DOCTYPE html><html>  <head>    <title>Menampilkan Gambar pada HTML</title>  </head>  <body>    <h3>Single Picture</h3>    <img src="https://images.pexels.com/photos/326012/pexels-photo-326012.jpeg" width="200" height="200" alt="SMK Telkom Malang">      <h3>Picture with text</h3>    <img src="https://images.pexels.com/photos/326012/pexels-photo-326012.jpeg" width="70" height="80" align="left"    hspace="20" vspace="20" alt="SMK Telkom Malang">    Lorem Ipsum is simply dummy text of the printing and typesetting industry.    Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,    when an unknown printer took a galley of type and scrambled it to make a type specimen book.    It has survived not only five centuries, but also the leap into electronic typesetting,    remaining essentially unchanged. It was popularised in the 1960s with the release of    Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing    software like Aldus PageMaker including versions of Lorem Ipsum.  </body></html>""";
    } else if (tag == "video") {
      return """<!DOCTYPE html><html>  <head>    <title>Multimedia</title>  </head>  <body>    <h3>Video</h3>    <video controls>      <source src="https://media.istockphoto.com/id/1406192572/id/video/kelinci-makan-selada.mp4?s=mp4-640x640-is&k=20&c=GyVT1vKr18AnK-lRTUkXHhnnk6YvL4cns0rMyiG5Sik=" type="video/mp4">    </video>  </body></html>""";
    } else {
      return """<!DOCTYPE html><html>  <head>    <title>Multimedia</title>  </head>  <body>    <h3>Audio</h3>    <audio controls>      <source src="https://drive.google.com/uc?export=view&id=1aAiZj8ryCv2iEOYxcsCmrLD5KOodyj7M" type="audio/mp3">        Browser doesn't support audio        <!--        "controls" digunakan untuk menampilkan control audio (play/pause, volume)        pastikan file audio sudah terdapat pada folder yang sama dengan file html        kalimat "Browser...." ditampilkan jika browser tidak support audio -->    </audio>  </body></html>""";
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
                      "HTML / Tampilan format multimedia pada HTML",
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
                        child: const Column(children: [
                          Text(
                            "  Konten multimedia merupakan salah satu bagian penting dari sebuah halaman web. Konten multimedia yang pada umumnya terdapat pada halaman web adalah gambar, audio, dan video. Dengan adanya konten multimedia, halaman web yang dibuat akan lebih terlihat menarik karena tidak berisi full text saja.",
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "  Untuk menambahkan gambar pada halaman web dapat menggunakan tag <img> yang setidaknya mempunyai atribut src, width, dan height. Atribut “src” untuk menunjukkan path pemnyimpanan gambar yang akan ditampilkan. Atribut “width” untuk menunjukkan lebar gambar pada halaman web. Atribut “height” untuk menunjukkan tinggi dari gambar pada halaman web.",
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "  Untuk menambahkan audio pada halaman web dapat menggunkan tag <audio> dan untuk video menggunakan tag <video>. Pada tag <audio> maupun <video> terdapat atribut “controls” yang digunakan untuk menampilkan tombol control (play, pause, stop, volume). Sedangkan untuk memanggil file audio maupun video yang akan ditampilkan dapat menggunakan tag <source>.",
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
                                    title: "img",
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
                                    title: "audio",
                                    onPressed: (text) {
                                      DbHelper.updateDbInteraktifProgressHtml(
                                          4, 1, 100);
                                      setState(() {
                                        tag = text;
                                        wvcontroller.loadHtmlString(
                                            textExeInteraktif());
                                      });
                                    },
                                    selected: tag,
                                  ),
                                  TagWidget(
                                    title: "video",
                                    onPressed: (text) {
                                      DbHelper.updateDbInteraktifProgressHtml(
                                          4, 2, 100);
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
