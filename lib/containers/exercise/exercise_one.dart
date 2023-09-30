import 'package:c3web/widgets/templates/button.dart';
import 'package:c3web/widgets/templates/header_back.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/theme_map.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class ExerciseOne extends StatefulWidget {
  const ExerciseOne({super.key});

  @override
  State<ExerciseOne> createState() => _ExerciseOneState();
}

class _ExerciseOneState extends State<ExerciseOne>
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
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
    Factory(() => EagerGestureRecognizer())
  };

  @override
  void initState() {
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }
    wvcontroller = WebViewController.fromPlatformCreationParams(params);
    wvcontroller.enableZoom(true);
    wvcontroller.loadHtmlString("""<html></html>""");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size(0.0, 0.0),
            child: Container(
              decoration: const BoxDecoration(color: Colors.white),
            )),
        body: Column(children: [
          HeaderBackWidget(
            title: "Compiler",
          ),
          Expanded(
              child: ListView(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                    color: const Color(0xFFE2F3FB),
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Soal",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              "Buatlah kode HTML pada compiler untuk membuat tampilan seperti gambar berikut ini!"),
                          SizedBox(
                            height: 20,
                          ),
                          SvgPicture.asset("assets/img/exercise1.svg",
                              width: 200)
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
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
                                        wvcontroller.loadHtmlString(
                                            """<html></html>""");
                                      } else {
                                        wvcontroller.loadHtmlString(codeEditor);
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
                                      textAlignVertical: TextAlignVertical.top,
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
                                  controller: wvcontroller),
                            )
                          ]),
                    ),
                  ],
                ),
              ),
            ],
          ))
        ]));
  }
}
