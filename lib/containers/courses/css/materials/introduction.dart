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
import 'package:c3web/helpers/db_helper.dart';

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
  String tag = 'style';
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
    DbHelper.updateDbMateriProgressCss(0);
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
          DbHelper.updateDbInteraktifProgressCss(0, 0, 100);
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
    return """<!DOCTYPE html>\n<html> \n<style></style>\n</html>""";
  }

  String textExeInteraktif() {
    return r"""<!DOCTYPE html><html> <style></style></html>""";
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
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                """Terdapat 3 tata cara penulisan CSS pada HTML, yaitu:
-	Inline Style
-	Internal Style Sheet
-	External Style Sheet
""",
                                style: TextStyle(fontSize: 12),
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
                                    title: "style",
                                    onPressed: (text) {
                                      setState(() {
                                        tag = text;
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
