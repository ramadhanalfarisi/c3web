import 'package:c3web/db/css_course_db.dart';
import 'package:c3web/db/html_course_db.dart';
import 'package:c3web/db/js_course_db.dart';
import 'package:hive/hive.dart';

class DbHelper {
  static updateDbMateriProgressHtml(int index) {
    Box<HtmlCourse> dataBox = Hive.box('html_course_box');
    HtmlCourse data = dataBox.getAt(index)!;
    data.progressMateri = 100;
    HtmlCourse newData = data;
    dataBox.putAt(index, newData);
  }

  static updateDbInteraktifProgressHtml(int index, int index2, int progress) {
    Box<HtmlCourse> dataBox = Hive.box('html_course_box');
    HtmlCourse data = dataBox.getAt(index)!;
    data.progressInteraktif[index2] = progress;
    HtmlCourse newData = data;
    dataBox.putAt(index, newData);
  }

  static updateDbMateriProgressCss(int index) {
    Box<CssCourse> dataBox = Hive.box('css_course_box');
    CssCourse data = dataBox.getAt(index)!;
    data.progressMateri = 100;
    CssCourse newData = data;
    dataBox.putAt(index, newData);
  }

  static updateDbInteraktifProgressCss(int index, int index2, int progress) {
    Box<CssCourse> dataBox = Hive.box('css_course_box');
    CssCourse data = dataBox.getAt(index)!;
    data.progressInteraktif[index2] = progress;
    CssCourse newData = data;
    dataBox.putAt(index, newData);
  }

  static updateDbMateriProgressJs(int index) {
    Box<JsCourse> dataBox = Hive.box('js_course_box');
    JsCourse data = dataBox.getAt(index)!;
    data.progressMateri = 100;
    JsCourse newData = data;
    dataBox.putAt(index, newData);
  }

  static updateDbInteraktifProgressJs(int index, int index2, int progress) {
    Box<JsCourse> dataBox = Hive.box('js_course_box');
    JsCourse data = dataBox.getAt(index)!;
    data.progressInteraktif[index2] = progress;
    JsCourse newData = data;
    dataBox.putAt(index, newData);
  }
}
