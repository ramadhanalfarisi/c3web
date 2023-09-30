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

class FormatForm extends StatefulWidget {
  const FormatForm({super.key});

  @override
  State<FormatForm> createState() => _FormatFormState();
}

class _FormatFormState extends State<FormatForm>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  BorderRadiusGeometry borderRadiusTab = const BorderRadius.only(
      topLeft: Radius.circular(10), bottomLeft: Radius.circular(10));
  String tag = 'form';
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
    DbHelper.updateDbMateriProgressHtml(6);
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
          DbHelper.updateDbInteraktifProgressHtml(6, 0, 100);
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
    return """<!DOCTYPE html>\n<html>\n  <head>\n    <title>Form Control</title>\n  </head>\n  <body>\n    <h3>Form Control pada HTML</h3>\n    <form class="" action="index.html" method="post">\n      <table cellpadding="5">\n        <tr>\n          <td>Input Text</td>\n          <td><input type="text" name="teks" value="" placeholder="Nama Lengkap"></td> \n        </tr>\n        <tr>\n          <td>Textarea</td>\n          <td><textarea name="name" rows="5" cols="30" placeholder="Alamat Lengkap"></textarea></td>\n          \n        </tr>\n        <tr>\n          <td>Input Number</td>\n          <td><input type="number" name="angka" value="" placeholder="Usia"></td>\n        </tr>\n        <tr>\n          <td>Input Password</td>\n          <td><input type="password" name="password" value="" placeholder="Password"></td>\n        </tr>\n        <tr>\n          <td>Input Date</td>\n          <td><input type="date" name="tanggal" value=""></td>\n        </tr>\n        <tr>\n          <td>Input Time</td>\n          <td><input type="time" name="jam" value=""></td>\n        </tr>\n        <tr>\n          <td>Input Range</td>\n          <td><input type="range" name="range" value=""></td>\n        </tr>\n        <tr>\n          <td>Input Radio</td>\n          <td>\n            <input type="radio" name="gender" value="L"> Pria\n            <input type="radio" name="gender" value="P"> Wanita\n          </td>\n        </tr>\n        <tr>\n          <td>Checkbox</td>\n          <td>\n            <input type="checkbox" name="hobi[]" value="sepak bola"> Sepak Bola\n            <input type="checkbox" name="hobi[]" value="basket"> Basket\n            <input type="checkbox" name="hobi[]" value="voli"> Bola Voli\n          </td>\n        </tr>\n        <tr>\n          <td>Combo Box</td>\n          <td>\n            <select name="jurusan">\n              <option value="">--Pilih Jurusan--</option>\n              <option value="RPL">Rekayasa Perangkat Lunak</option>\n              <option value="TKJ">Teknik Komputer dan Jaringan</option>\n            </select>\n          </td>\n        </tr>\n        <tr>\n          <td>Input File</td>\n          <td><input type="file" name="file" value=""></td>\n        </tr>\n        <tr>\n          <td>Input Color</td>\n          <td><input type="color" name="warna" value=""></td>\n        </tr>\n        <tr>\n          <td>Tombol</td>\n          <td>\n            <button type="button" name="button">Tombol Biasa</button>\n            <button type="submit" name="button">Tombol Submit Data</button>\n            <button type="reset" name="button">Tombol Reset</button> \n          </td>\n        </tr>\n      </table>\n    </form>\n  </body>\n</html>""";
  }

  String textExeInteraktif() {
    return """<!DOCTYPE html><html>  <head>    <title>Form Control</title>  </head>  <body>    <h3>Form Control pada HTML</h3>    <form class="" action="index.html" method="post">      <table cellpadding="5">        <tr>          <td>Input Text</td>          <td><input type="text" name="teks" value="" placeholder="Nama Lengkap"></td>         </tr>        <tr>          <td>Textarea</td>          <td><textarea name="name" rows="5" cols="30" placeholder="Alamat Lengkap"></textarea></td>                  </tr>        <tr>          <td>Input Number</td>          <td><input type="number" name="angka" value="" placeholder="Usia"></td>        </tr>        <tr>          <td>Input Password</td>          <td><input type="password" name="password" value="" placeholder="Password"></td>        </tr>        <tr>          <td>Input Date</td>          <td><input type="date" name="tanggal" value=""></td>        </tr>        <tr>          <td>Input Time</td>          <td><input type="time" name="jam" value=""></td>        </tr>        <tr>          <td>Input Range</td>          <td><input type="range" name="range" value=""></td>        </tr>        <tr>          <td>Input Radio</td>          <td>            <input type="radio" name="gender" value="L"> Pria            <input type="radio" name="gender" value="P"> Wanita          </td>        </tr>        <tr>          <td>Checkbox</td>          <td>            <input type="checkbox" name="hobi[]" value="sepak bola"> Sepak Bola            <input type="checkbox" name="hobi[]" value="basket"> Basket            <input type="checkbox" name="hobi[]" value="voli"> Bola Voli          </td>        </tr>        <tr>          <td>Combo Box</td>          <td>            <select name="jurusan">              <option value="">--Pilih Jurusan--</option>              <option value="RPL">Rekayasa Perangkat Lunak</option>              <option value="TKJ">Teknik Komputer dan Jaringan</option>            </select>          </td>        </tr>        <tr>          <td>Input File</td>          <td><input type="file" name="file" value=""></td>        </tr>        <tr>          <td>Input Color</td>          <td><input type="color" name="warna" value=""></td>        </tr>        <tr>          <td>Tombol</td>          <td>            <button type="button" name="button">Tombol Biasa</button>            <button type="submit" name="button">Tombol Submit Data</button>            <button type="reset" name="button">Tombol Reset</button>           </td>        </tr>      </table>    </form>  </body></html>""";
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
                      "HTML / Format formulir pada HTML",
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
                            "  Formulir atau lebih dikenal dengan istilah form pada halaman web digunakan sebagai control atau input dari user pada halaman web. Fungsi lain dari adanya form adalah agar halaman web yang dibuat lebih interaktif terhadap user. Berikut ini nama-nama elemen HTML yang digunakan untuk formulir pada halaman web.",
                            style: TextStyle(fontSize: 12),
                          ),
                          SvgPicture.asset(
                            "assets/img/img_formatform.svg",
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
                                    title: "form",
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
