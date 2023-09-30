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

class Operator extends StatefulWidget {
  const Operator({super.key});

  @override
  State<Operator> createState() => _OperatorState();
}

class _OperatorState extends State<Operator>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  BorderRadiusGeometry borderRadiusTab = const BorderRadius.only(
      topLeft: Radius.circular(10), bottomLeft: Radius.circular(10));
  String tag = 'operator';
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
    DbHelper.updateDbMateriProgressJs(2);
    wvcontroller = WebViewController.fromPlatformCreationParams(params);
    wvcontroller2 = WebViewController.fromPlatformCreationParams(params);
    wvcontroller.setJavaScriptMode(JavaScriptMode.unrestricted);
    wvcontroller2.setJavaScriptMode(JavaScriptMode.unrestricted);
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
          DbHelper.updateDbInteraktifProgressJs(2, 0, 100);
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
    return """<!DOCTYPE html>\n<html lang="en" dir="ltr">\n  <head>\n    <meta charset="utf-8" />\n    <meta name="viewport" content="width=device-width, initial-scale=1.0" />\n    <title>Calculator Web</title>\n    <!-- load bootstrap css -->\n    <link rel="stylesheet" href="assets/css/bootstrap.min.css">\n    <style media="screen">\n      .screen {\n        height: 60px;\n        font-size: 30px;\n        margin-bottom: 10px;\n      }\n    </style>\n    <!-- load jquery and bootstrap js -->\n    <script src="assets/js/jquery-3.7.1.slim.js"></script>\n    <script src="assets/js/popper.js"></script>\n    <script src="assets/js/bootstrap.min.js"></script>\n    <!-- <script src="calculator.js"></script> -->\n    <script type="text/javascript">\n      let temp = 0; // untuk menyimpan angka sementara\n      let opr = ""; // untuk menyimpan operasi sementara\n      // fungsi untuk menampilkan angka ke display\n      ShowNumber = (number) => {\n        let screen = document.getElementById("screen").value;\n        // jika tampilan display masih kosong,\n        // maka angka langsung ditambahkan\n        // Number(..) digunakan untuk konversi ke tipe numeric\n        if (Number(screen) == 0) {\n          document.getElementById("screen").value = number;\n          // jika display sudah ada angkanya,\n          // maka angka digabungkan\n        } else {\n          document.getElementById("screen").value += number;\n        }\n      };\n      Operation = (operator) => {\n        // mengambil nilai dari display\n        let screen = document.getElementById("screen").value;\n        // jika nilai temp masing kosong, maka\n        // nilai temp akan diisi dengan angka yang ada di display\n        if (temp == 0) {\n          temp = Number(screen);\n          // jika nilai temp sudah ada,\n          // maka nilai temp akan diolah sesuai dengan operasi yang ada\n        } else {\n          if (opr == "+") {\n            temp += Number(screen);\n          } else if (opr == "-") {\n            temp -= Number(screen);\n          } else if (opr == "*") {\n            temp *= Number(screen);\n          } else if (opr == "/") {\n            if (Number(screen) == 0) {\n              alert("Cannot devide by zero");\n            } else {\n              temp /= Number(screen);\n            }\n          }\n        }\n        opr = operator;\n        // ketika tombol operator diklik maka tampilan display akan kosong\n        document.getElementById("screen").value = "";\n      };\n\n      ShowResult = () => {\n        // fungsi untuk tombol sama dengan (=)\n        // ketika fungsi ini dipanggil maka akan display menampilkan\n        // hasil perhitungan\n        let screen = document.getElementById("screen").value;\n        if (opr == "+") {\n          temp += Number(screen);\n          document.getElementById("screen").value = temp;\n        } else if (opr == "-") {\n          temp -= Number(screen);\n          document.getElementById("screen").value = temp;\n        } else if (opr == "*") {\n          temp *= Number(screen);\n          document.getElementById("screen").value = temp;\n        } else if (opr == "/") {\n          if (Number(screen) == 0) {\n            alert("Cannot devide by zero");\n          } else {\n            temp /= Number(screen);\n            document.getElementById("screen").value = temp;\n          }\n        }\n      };\n\n      Reset = () => {\n        // fungsi untuk mereset calculator\n        temp = 0;\n        document.getElementById("screen").value = "";\n      };\n    </script>\n  </head>\n  <body>\n    <div class="container">\n      <div class="col-sm-5">\n        <div class="card col-sm-12">\n          <div class="card-header bg-primary text-white">\n            <h4>Basic Calculator</h4>\n          </div>\n          <div class="card-body">\n            <div class="row">\n              <div class="col-sm-12">\n                <input\n                  type="text"\n                  id="screen"\n                  class="form-control screen"\n                  readonly\n                />\n              </div>\n\n              <div class="col-sm-3">\n                <button\n                  type="button"\n                  class="btn btn-dark btn-block"\n                  onclick="ShowNumber('1');"\n                >\n                  <h3>1</h3>\n                </button>\n                <button\n                  type="button"\n                  class="btn btn-dark btn-block"\n                  onclick="ShowNumber('4');"\n                >\n                  <h3>4</h3>\n                </button>\n                <button\n                  type="button"\n                  class="btn btn-dark btn-block"\n                  onclick="ShowNumber('7');"\n                >\n                  <h3>7</h3>\n                </button>\n                <button\n                  type="button"\n                  class="btn btn-dark btn-block"\n                  onclick="Reset();"\n                >\n                  <h3>CE</h3>\n                </button>\n              </div>\n              <div class="col-sm-3">\n                <button\n                  type="button"\n                  class="btn btn-dark btn-block"\n                  onclick="ShowNumber('2');"\n                >\n                  <h3>2</h3>\n                </button>\n                <button\n                  type="button"\n                  class="btn btn-dark btn-block"\n                  onclick="ShowNumber('5');"\n                >\n                  <h3>5</h3>\n                </button>\n                <button\n                  type="button"\n                  class="btn btn-dark btn-block"\n                  onclick="ShowNumber('8');"\n                >\n                  <h3>8</h3>\n                </button>\n                <button\n                  type="button"\n                  class="btn btn-dark btn-block"\n                  onclick="ShowNumber('0');"\n                >\n                  <h3>0</h3>\n                </button>\n              </div>\n              <div class="col-sm-3">\n                <button\n                  type="button"\n                  class="btn btn-dark btn-block"\n                  onclick="ShowNumber('3');"\n                >\n                  <h3>3</h3>\n                </button>\n                <button\n                  type="button"\n                  class="btn btn-dark btn-block"\n                  onclick="ShowNumber('6');"\n                >\n                  <h3>6</h3>\n                </button>\n                <button\n                  type="button"\n                  class="btn btn-dark btn-block"\n                  onclick="ShowNumber('9');"\n                >\n                  <h3>9</h3>\n                </button>\n                <button\n                  type="button"\n                  class="btn btn-dark btn-block"\n                  onclick="ShowResult();"\n                >\n                  <h3>=</h3>\n                </button>\n              </div>\n              <div class="col-sm-3">\n                <button\n                  type="button"\n                  class="btn btn-dark btn-block"\n                  onclick="Operation('*');"\n                >\n                  <h3>x</h3>\n                </button>\n                <button\n                  type="button"\n                  class="btn btn-dark btn-block"\n                  onclick="Operation('/');"\n                >\n                  <h3>/</h3>\n                </button>\n                <button\n                  type="button"\n                  class="btn btn-dark btn-block"\n                  onclick="Operation('-');"\n                >\n                  <h3>-</h3>\n                </button>\n                <button\n                  type="button"\n                  class="btn btn-dark btn-block"\n                  onclick="Operation('+');"\n                >\n                  <h3>+</h3>\n                </button>\n              </div>\n            </div>\n          </div>\n        </div>\n      </div>\n    </div>\n  </body>\n</html>""";
  }

  String textExeInteraktif() {
    return """<!DOCTYPE html><html lang="en" dir="ltr">  <head>    <meta charset="utf-8" />    <meta name="viewport" content="width=device-width, initial-scale=1.0" />    <title>Calculator Web</title>    <!-- load bootstrap css -->    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">    <style media="screen">      .screen {        height: 60px;        font-size: 30px;        margin-bottom: 10px;      }    </style>    <!-- load jquery and bootstrap js -->    <script src="https://code.jquery.com/jquery-3.7.1.slim.js" integrity="sha256-UgvvN8vBkgO0luPSUl2s8TIlOSYRoGFAX4jlCIm9Adc=" crossorigin="anonymous"></script>    <script src="https://unpkg.com/@popperjs/core@2"></script>    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>    <!-- <script src="calculator.js"></script> -->    <script type="text/javascript">      let temp = 0; // untuk menyimpan angka sementara      let opr = ""; // untuk menyimpan operasi sementara      // fungsi untuk menampilkan angka ke display      ShowNumber = (number) => {        let screen = document.getElementById("screen").value;        // jika tampilan display masih kosong,        // maka angka langsung ditambahkan        // Number(..) digunakan untuk konversi ke tipe numeric        if (Number(screen) == 0) {          document.getElementById("screen").value = number;          // jika display sudah ada angkanya,          // maka angka digabungkan        } else {          document.getElementById("screen").value += number;        }      };      Operation = (operator) => {        // mengambil nilai dari display        let screen = document.getElementById("screen").value;        // jika nilai temp masing kosong, maka        // nilai temp akan diisi dengan angka yang ada di display        if (temp == 0) {          temp = Number(screen);          // jika nilai temp sudah ada,          // maka nilai temp akan diolah sesuai dengan operasi yang ada        } else {          if (opr == "+") {            temp += Number(screen);          } else if (opr == "-") {            temp -= Number(screen);          } else if (opr == "*") {            temp *= Number(screen);          } else if (opr == "/") {            if (Number(screen) == 0) {              alert("Cannot devide by zero");            } else {              temp /= Number(screen);            }          }        }        opr = operator;        // ketika tombol operator diklik maka tampilan display akan kosong        document.getElementById("screen").value = "";      };      ShowResult = () => {        // fungsi untuk tombol sama dengan (=)        // ketika fungsi ini dipanggil maka akan display menampilkan        // hasil perhitungan        let screen = document.getElementById("screen").value;        if (opr == "+") {          temp += Number(screen);          document.getElementById("screen").value = temp;        } else if (opr == "-") {          temp -= Number(screen);          document.getElementById("screen").value = temp;        } else if (opr == "*") {          temp *= Number(screen);          document.getElementById("screen").value = temp;        } else if (opr == "/") {          if (Number(screen) == 0) {            alert("Cannot devide by zero");          } else {            temp /= Number(screen);            document.getElementById("screen").value = temp;          }        }      };      Reset = () => {        // fungsi untuk mereset calculator        temp = 0;        document.getElementById("screen").value = "";      };    </script>  </head>  <body>    <div class="container">      <div class="col-sm-5">        <div class="card col-sm-12">          <div class="card-header bg-primary text-white">            <h4>Basic Calculator</h4>          </div>          <div class="card-body">            <div class="row">              <div class="col-sm-12">                <input                  type="text"                  id="screen"                  class="form-control screen"                  readonly                />              </div>              <div class="col-sm-3">                <button                  type="button"                  class="btn btn-dark btn-block"                  onclick="ShowNumber('1');"                >                  <h3>1</h3>                </button>                <button                  type="button"                  class="btn btn-dark btn-block"                  onclick="ShowNumber('4');"                >                  <h3>4</h3>                </button>                <button                  type="button"                  class="btn btn-dark btn-block"                  onclick="ShowNumber('7');"                >                  <h3>7</h3>                </button>                <button                  type="button"                  class="btn btn-dark btn-block"                  onclick="Reset();"                >                  <h3>CE</h3>                </button>              </div>              <div class="col-sm-3">                <button                  type="button"                  class="btn btn-dark btn-block"                  onclick="ShowNumber('2');"                >                  <h3>2</h3>                </button>                <button                  type="button"                  class="btn btn-dark btn-block"                  onclick="ShowNumber('5');"                >                  <h3>5</h3>                </button>                <button                  type="button"                  class="btn btn-dark btn-block"                  onclick="ShowNumber('8');"                >                  <h3>8</h3>                </button>                <button                  type="button"                  class="btn btn-dark btn-block"                  onclick="ShowNumber('0');"                >                  <h3>0</h3>                </button>              </div>              <div class="col-sm-3">                <button                  type="button"                  class="btn btn-dark btn-block"                  onclick="ShowNumber('3');"                >                  <h3>3</h3>                </button>                <button                  type="button"                  class="btn btn-dark btn-block"                  onclick="ShowNumber('6');"                >                  <h3>6</h3>                </button>                <button                  type="button"                  class="btn btn-dark btn-block"                  onclick="ShowNumber('9');"                >                  <h3>9</h3>                </button>                <button                  type="button"                  class="btn btn-dark btn-block"                  onclick="ShowResult();"                >                  <h3>=</h3>                </button>              </div>              <div class="col-sm-3">                <button                  type="button"                  class="btn btn-dark btn-block"                  onclick="Operation('*');"                >                  <h3>x</h3>                </button>                <button                  type="button"                  class="btn btn-dark btn-block"                  onclick="Operation('/');"                >                  <h3>/</h3>                </button>                <button                  type="button"                  class="btn btn-dark btn-block"                  onclick="Operation('-');"                >                  <h3>-</h3>                </button>                <button                  type="button"                  class="btn btn-dark btn-block"                  onclick="Operation('+');"                >                  <h3>+</h3>                </button>              </div>            </div>          </div>        </div>      </div>    </div>  </body></html>""";
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
                      "JS / Operator",
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
                            """Operator digunakan untuk mengolah atau memanipulasi data. Terdapat beberapa macam jenis operator pada javascript yaitu sebagai berikut.
-	Operator Aritmatik
Terdapat beberapa macam operator aritmatik, yaitu sebagai berikut.
▪	+ digunakan untuk operasi penjumlahan jika data yang diolah berupa data numeric, digunakan untuk operasi menggabungkan string jika data yang diolah berupa tipe string.
▪	- digunakan untuk operasi pengurangan.
▪	* digunakan untuk operasi perkalian
▪	/ digunakan untuk operasi pembagian
▪	% digunakan untuk operasi pencarian sisa bagi
▪	++ digunakan untuk increment sebuah nilai
▪	-- digunakan untuk decrement sebuah nilai
-	Operator Perbandingan
Terdapat beberapa macam operator perbandingan, yaitu sebagai berikut.
▪	> lebih dari
▪	>= lebih dari sama dengan
▪	< kurang dari
▪	<= kurang dari sama dengan
▪	== sama dengan
-	Operator Logika
Terdapat beberapa macam operator logika yaitu sebagai berikut.
▪	&& logika AND
▪	|| logika OR
▪	! logika NOT
Operator Assignment, operator assignment (=) digunakan untuk menyimpan sebuah nilai ke variabel atau disebut juga dengan operator penugasan.
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
                                    title: "operator",
                                    onPressed: (text) {
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
