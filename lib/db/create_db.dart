import 'dart:io';

import 'package:c3web/db/css_course_db.dart';
import 'package:c3web/db/css_quiz_db.dart';
import 'package:c3web/db/html_course_db.dart';
import 'package:c3web/db/html_quiz_db.dart';
import 'package:c3web/db/js_quiz_db.dart';
import 'package:c3web/db/js_course_db.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class DB {
  initializeDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    Hive.registerAdapter(HtmlCourseAdapter());
    Hive.registerAdapter(CssCourseAdapter());
    Hive.registerAdapter(JsCourseAdapter());
    Hive.registerAdapter(HtmlQuizAdapter());
    Hive.registerAdapter(CssQuizAdapter());
    Hive.registerAdapter(JsQuizAdapter());
    await Hive.openBox<HtmlCourse>('html_course_box');
    await Hive.openBox<CssCourse>('css_course_box');
    await Hive.openBox<JsCourse>('js_course_box');
    await Hive.openBox<HtmlQuiz>('html_quiz_box');
    await Hive.openBox<CssQuiz>('css_quiz_box');
    await Hive.openBox<JsQuiz>('js_quiz_box');
    initializeHtmlCourse();
    initializeCssCourse();
    initializeJsCourse();
    initializeHtmlQuiz();
    initializeCssQuiz();
    initializeJsQuiz();
  }

  initializeHtmlCourse() async {
    Box<HtmlCourse> box = await Hive.openBox<HtmlCourse>('html_course_box');
    List<Map<String, dynamic>> dataHtml = [
      {
        "id": 1,
        "title": "Konsep HTML",
        "desc":
            "HTTP (Hypertext transfer protocol) merupakan protokol yang digunakan untuk mentransfer data antara web server ke web browser.",
        "progress_materi": 0,
        "progress_interaktif": [0, 0, 0]
      },
      {
        "id": 2,
        "title": "Format teks HTML",
        "desc":
            "HTML 5 menyediakan beberapa tag yang digunakan untuk membuat berbagai macam format teks.",
        "progress_materi": 0,
        "progress_interaktif": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
      },
      {
        "id": 3,
        "title": "Format list pada HTML",
        "desc":
            "List adalah bagian teks di dalam dokumen yang berisi daftar item dari suatu kelompok atau grup tertentu.",
        "progress_materi": 0,
        "progress_interaktif": [0, 0]
      },
      {
        "id": 4,
        "title": "Format tabel pada HTML",
        "desc":
            "Tabel digunakan untuk menampilkan data tabular dalam bentuk baris dan kolom.",
        "progress_materi": 0,
        "progress_interaktif": [0]
      },
      {
        "id": 5,
        "title": "Tampilan format multimedia pada HTML",
        "desc":
            "Konten multimedia merupakan salah satu bagian penting dari sebuah halaman web.",
        "progress_materi": 0,
        "progress_interaktif": [0, 0, 0]
      },
      {
        "id": 6,
        "title": "Format kaitan pada HTML",
        "desc":
            "Tautan atau link pada halaman web digunakan untuk menghubungkan atau berpindah dari satu halaman dengan halaman yang lain.",
        "progress_materi": 0,
        "progress_interaktif": [0]
      },
      {
        "id": 7,
        "title": "Format formulir pada HTML",
        "desc":
            "Formulir atau lebih dikenal dengan istilah form pada halaman web digunakan sebagai control atau input dari user pada halaman web.",
        "progress_materi": 0,
        "progress_interaktif": [0]
      }
    ];

    if (box.length <= 0) {
      for (Map<String, dynamic> course in dataHtml) {
        HtmlCourse htmlCourse = HtmlCourse(
            id: course["id"] as int,
            title: course["title"] as String,
            description: course["desc"] as String,
            progressMateri: course['progress_materi'] as int,
            progressInteraktif: course['progress_interaktif'] as List<int>);
        box.add(htmlCourse);
      }
    }
  }

  initializeCssCourse() async {
    Box<CssCourse> box = await Hive.openBox<CssCourse>('css_course_box');
    List<Map<String, dynamic>> dataCss = [
      {
        "id": 1,
        "title": "Konsep CSS",
        "desc":
            "CSS (Cascading Style Sheet) merupakan sekumpulan kode yang digunakan untuk mempercantik atau styling halaman web.",
        "progress_materi": 0,
        "progress_interaktif": [0]
      },
      {
        "id": 2,
        "title": "CSS Background",
        "desc":
            "CSS Background digunakan untuk mennentukan background dari sebuah elemen.",
        "progress_materi": 0,
        "progress_interaktif": [0, 0, 0, 0]
      },
      {
        "id": 3,
        "title": "CSS Dimension",
        "desc":
            "Dalam menentukan ukuran pada sebuah elemen, dapat dengan menggunakan width (untuk menentukan panjang elemen) dan height (untuk menentukan lebar atau tinggi element).",
        "progress_materi": 0,
        "progress_interaktif": [0]
      },
      {
        "id": 4,
        "title": "CSS Text",
        "desc":
            "CSS dapat mengatur style dari teks yang ada pada halaman web yang dibuat.",
        "progress_materi": 0,
        "progress_interaktif": [0, 0, 0, 0]
      },
      {
        "id": 5,
        "title": "CSS Border",
        "desc":
            "Beberapa elemen pada HTML mempunyai border atau garis tepi dari suatu komponen.",
        "progress_materi": 0,
        "progress_interaktif": [0]
      },
      {
        "id": 6,
        "title": "CSS Position dan Overflow",
        "desc":
            "Setiap elemen pada halaman web mempunyai posisi atau tata letak.",
        "progress_materi": 0,
        "progress_interaktif": [0]
      },
      {
        "id": 7,
        "title": "Navigation Bar",
        "desc":
            "Pada halaman sebuah website, sering kita jumpai menu bar atau navigasi bar yang berisi link-link menu yang terdapat pada halaman web tersebut.",
        "progress_materi": 0,
        "progress_interaktif": [0]
      },
      {
        "id": 8,
        "title": "Text in Multiple Column",
        "desc":
            "Sering kita jumpai halaman web yang berisi konten berita yang disajikan dalam beberapa kolom seperti layout pada koran.",
        "progress_materi": 0,
        "progress_interaktif": [0]
      },
      {
        "id": 9,
        "title": "Penggunaan Media Query",
        "desc":
            "Fitur media query adalah fitur untuk yang digunakan sebagai filter terhadap lebar layar pengguna.",
        "progress_materi": 0,
        "progress_interaktif": [0]
      },
      {
        "id": 10,
        "title": "Konsep Grid pada Halaman Web",
        "desc":
            "Konsep grid merupakan sebuah trik untuk membagi lebar layar menjadi 12 bagian.",
        "progress_materi": 0,
        "progress_interaktif": [0]
      },
      {
        "id": 11,
        "title": "Pengertian CSS Responsive",
        "desc":
            "Beberapa elemen pada HTML mempunyai border atau garis tepi dari suatu komponen.",
        "progress_materi": 0,
        "progress_interaktif": [0]
      }
    ];

    if (box.length <= 0) {
      for (Map<String, dynamic> course in dataCss) {
        CssCourse htmlCourse = CssCourse(
            id: course["id"] as int,
            title: course["title"] as String,
            description: course["desc"] as String,
            progressMateri: course['progress_materi'] as int,
            progressInteraktif: course['progress_interaktif'] as List<int>);
        box.add(htmlCourse);
      }
    }
  }

  initializeJsCourse() async {
    Box<JsCourse> box = await Hive.openBox<JsCourse>('js_course_box');
    List<Map<String, dynamic>> dataJs = [
      {
        "id": 1,
        "title": "Pengertian Javascript",
        "desc":
            "Javascript merupakan bahasa pemrograman berbasis Java yang diterapkan pada halaman web.",
        "progress_materi": 0,
        "progress_interaktif": [0]
      },
      {
        "id": 2,
        "title": "Variabel dan Tipe Data pada Javascript",
        "desc":
            "Variabel merupakan sebuah tempat untuk menyimpan sebuah data. Data yang disimpan tentu mempunyai karakteristik data yang disebut tipe data.",
        "progress_materi": 0,
        "progress_interaktif": [0]
      },
      {
        "id": 3,
        "title": "Operator",
        "desc": "Operator digunakan untuk mengolah atau memanipulasi data.",
        "progress_materi": 0,
        "progress_interaktif": [0]
      },
      {
        "id": 4,
        "title": "Pembuatan Function pada Javascript",
        "desc":
            "Function merupakan sebuah blok kode yang akan dieksekusi ketika dipanggil.",
        "progress_materi": 0,
        "progress_interaktif": [0]
      },
    ];

    if (box.length <= 0) {
      for (Map<String, dynamic> course in dataJs) {
        JsCourse jsCourse = JsCourse(
            id: course["id"] as int,
            title: course["title"] as String,
            description: course["desc"] as String,
            progressMateri: course['progress_materi'] as int,
            progressInteraktif: course['progress_interaktif'] as List<int>);
        box.add(jsCourse);
      }
    }
  }

  initializeHtmlQuiz() async {
    Box<HtmlQuiz> box = await Hive.openBox<HtmlQuiz>('html_quiz_box');
    List<Map<String, dynamic>> dataHtml = [
      {
        "id": 1,
        "question": "Tag perintah untuk mengganti baris pada HTML adalah...",
        "answer": "B",
        "options": [
          {"key": "A", "text": "<tr>"},
          {"key": "B", "text": "<br>"},
          {"key": "C", "text": "<p>"},
          {"key": "D", "text": "<td>"},
          {"key": "E", "text": "<insert>"}
        ],
        "image": ""
      },
      {
        "id": 2,
        "question":
            "Komponen form yang ditunjukkan oleh nomor 1 dan 2 adalah...",
        "answer": "B",
        "options": [
          {"key": "A", "text": "Radio dan textarea"},
          {"key": "B", "text": "Textarea dan radio"},
          {"key": "C", "text": "Textarea dan checkbox"},
          {"key": "D", "text": "Input text dan radio"},
          {"key": "E", "text": "Input text dan checkbox"}
        ],
        "image": "assets/img/quizform.svg"
      },
      {
        "id": 3,
        "question":
            "Untuk membuat link ke www.google.com, perintah yang digunakan adalah…",
        "answer": "C",
        "options": [
          {"key": "A", "text": "<href a=“www.google.com”> </a>"},
          {"key": "B", "text": "<a href www.google.com> </a>"},
          {"key": "C", "text": "<a href=“www.google.com”> </a>"},
          {"key": "D", "text": "<a href=www.google.com> </a>"},
          {"key": "E", "text": "<href a=www.google.com> </a>"}
        ],
        "image": ""
      },
      {
        "id": 4,
        "question":
            "Tag yang digunakan untuk memformat teks menjadi tercetak miring pada HTML adalah…",
        "answer": "A",
        "options": [
          {"key": "A", "text": "<i>"},
          {"key": "B", "text": "<u>"},
          {"key": "C", "text": "<b>"},
          {"key": "D", "text": "<r>"},
          {"key": "E", "text": "<c>"}
        ],
        "image": ""
      },
      {
        "id": 5,
        "question":
            "Tag yang digunakan untuk memformat teks menjadi tercetak tebal pada HTML adalah…",
        "answer": "C",
        "options": [
          {"key": "A", "text": "<i>"},
          {"key": "B", "text": "<u>"},
          {"key": "C", "text": "<b>"},
          {"key": "D", "text": "<r>"},
          {"key": "E", "text": "<c>"}
        ],
        "image": ""
      },
      {
        "id": 6,
        "question": "Tag <a> digunakan untuk…",
        "answer": "D",
        "options": [
          {"key": "A", "text": "Membuat tabel"},
          {"key": "B", "text": "Memformat teks menjadi tercetak miring"},
          {"key": "C", "text": "Memformat teks menjadi tercetak tebal"},
          {"key": "D", "text": "Membuat hyperlink"},
          {"key": "E", "text": "Memformat teks menjadi tercetak bergaris bawah"}
        ],
        "image": ""
      },
      {
        "id": 7,
        "question":
            "File gambar dimasukkan ke dalam dokumen HTML menggunakan tag...",
        "answer": "C",
        "options": [
          {"key": "A", "text": "<BR>"},
          {"key": "B", "text": "<doc src='...'>"},
          {"key": "C", "text": "<img src='...'>	"},
          {"key": "D", "text": "<html src='...'>"},
          {"key": "E", "text": "<embed src='...'>"}
        ],
        "image": ""
      },
      {
        "id": 8,
        "question":
            "Contoh penulisan syntax HTML untuk menjadikan beberapa baris dalam table menjadi satu adalah...",
        "answer": "E",
        "options": [
          {"key": "A", "text": "<table colspan=”3”>"},
          {"key": "B", "text": "<tr colspan=”3”>"},
          {"key": "C", "text": "<td colspan=”3”>"},
          {"key": "D", "text": "<tr rowspan=”3”>"},
          {"key": "E", "text": "<td rowspan=”3”>"}
        ],
        "image": ""
      },
      {
        "id": 9,
        "question": "Di dalam sebuah tabel, kolom dibentuk dengan tag…",
        "answer": "B",
        "options": [
          {"key": "A", "text": "<tr></tr>"},
          {"key": "B", "text": "<td></td>"},
          {"key": "C", "text": "<tb></tb>"},
          {"key": "D", "text": "<th></th>"},
          {"key": "E", "text": "<table></table>"}
        ],
        "image": ""
      },
      {
        "id": 10,
        "question":
            "Untuk mengambil nilai/value dari inputan “Nama Lengkap” menggunakan…",
        "answer": "A",
        "options": [
          {
            "key": "A",
            "text": "var nama = document.getElementById \n('nama').value;"
          },
          {
            "key": "B",
            "text": "var nama = document.getElementsByName \n('nama').value;"
          },
          {
            "key": "C",
            "text": "var nama = document.getElementById \n('nama');"
          },
          {
            "key": "D",
            "text": "var nama = document.getElementsByName \n('nama');"
          },
          {
            "key": "E",
            "text": "var nama = document.getElementById \n('nama').innerHTML;"
          }
        ],
        "image": "assets/img/quiznama.svg"
      },
    ];

    if (box.length <= 0) {
      for (Map<String, dynamic> quiz in dataHtml) {
        HtmlQuiz htmlQuiz = HtmlQuiz(
            id: quiz["id"] as int,
            answer: quiz["answer"] as String,
            options: quiz["options"] as List<Map<String, String>>,
            question: quiz["question"] as String,
            image: quiz["image"] as String);
        box.add(htmlQuiz);
      }
    }
  }

  initializeCssQuiz() async {
    Box<CssQuiz> box = await Hive.openBox<CssQuiz>('css_quiz_box');
    List<Map<String, dynamic>> dataCss = [
      {
        "id": 1,
        "question":
            "Script CSS memiliki kemampauan untuk membangun sebuah layout website. Apa fungsi property / value margin-left:15px; pada id atau class dalam sebuah script CSS ...",
        "answer": "C",
        "options": [
          {"key": "A", "text": "Memberikan jarak batas luar sebesar 15 px"},
          {"key": "B", "text": "Memberikan jarak batas dalam sebesar 15 px"},
          {
            "key": "C",
            "text": "Memberikan jarak batas luar bagian kiri sebesar 15 px;"
          },
          {
            "key": "D",
            "text": "Memberikan jarak batas dalam bagian kiri sebesar 15 px"
          },
          {
            "key": "E",
            "text": "Memberikan jarak batas dalam bagian kanan sebesar 15 px"
          }
        ],
        "image": ""
      },
      {
        "id": 2,
        "question":
            "Script CSS memiliki kemampauan untuk membangun sebuah layout website. Apa fungsi property / value posision:fixed; pada id atau class dalam sebuah script CSS ...",
        "answer": "A",
        "options": [
          {"key": "A", "text": "Penyimpan data website"},
          {
            "key": "B",
            "text": "Aplikasi sistem manajemen basisdata relasional"
          },
          {
            "key": "C",
            "text":
                "Perangkat utilitas yang digunakan untuk menyunting berkas halaman web"
          },
          {"key": "D", "text": "Sebuah alamat sebuah situs web"},
          {
            "key": "E",
            "text":
                "Aplikasi yang digunakan untuk membuka situs atau website yang akan kita kunjungi"
          }
        ],
        "image": ""
      },
      {
        "id": 3,
        "question":
            "Script CSS memiliki kemampauan untuk membangun sebuah layout website. Apa fungsi tag / value line-height:100%; pada id atau class dalam sebuah script CSS ...",
        "answer": "D",
        "options": [
          {
            "key": "A",
            "text": "untuk mengatur tinggi antar class sebesar 100 pixsel"
          },
          {
            "key": "B",
            "text": "untuk mengatur tinggi antar class sebesar 100 persen"
          },
          {
            "key": "C",
            "text":
                "untuk mengatur tinggi antar baris paragraf sebesar 100 pixsel"
          },
          {
            "key": "D",
            "text":
                "untuk mengatur tinggi antar baris paragraf sebesar 100 persen"
          },
          {
            "key": "E",
            "text": "untuk mengatur tinggi antar baris paragraf secara normal"
          }
        ],
        "image": ""
      },
      {
        "id": 4,
        "question":
            "Script CSS memiliki kemampauan untuk membangun sebuah layout website. Script untuk memanggil file CSS yang berada diluar file HTML ...",
        "answer": "D",
        "options": [
          {
            "key": "A",
            "text": '<link href="css/style.css" rel="search" type="text/css">'
          },
          {
            "key": "B",
            "text":
                '<link href="css/style.css" rel="subsection type="text/css">'
          },
          {"key": "C", "text": '<link rel=" search" type="text/css">'},
          {
            "key": "D",
            "text":
                '<link href="css/style.css" rel="stylesheet" type="text/css">'
          },
          {"key": "E", "text": '<link rel="stylesheet" type="text/css">'}
        ],
        "image": ""
      },
      {
        "id": 5,
        "question":
            "Script CSS memiliki kemampauan untuk membangun sebuah layout website. Apa fungsi property / value text-align:center; pada id atau class dalam sebuah script CSS ...",
        "answer": "D",
        "options": [
          {"key": "A", "text": 'Menjadikan teks rata kiri'},
          {"key": "B", "text": 'Menjadikan teks rata kanan'},
          {"key": "C", "text": 'Menjadikan teks rata tengah'},
          {"key": "D", "text": 'Menjadikan teks berada diposisi tengah'},
          {"key": "E", "text": 'Menjadikan teks agak menjorok ke tengah kiri'}
        ],
        "image": ""
      },
      {
        "id": 6,
        "question":
            "Salah satu jenis selector CSS adalah class. Untuk mendeklarasikan sebuah selector class tanda yang digunakan didepan nama class adalah ...",
        "answer": "A",
        "options": [
          {"key": "A", "text": 'Tanda titik “.”'},
          {"key": "B", "text": 'Tanda titik koma “;”'},
          {"key": "C", "text": 'Tanda kurung buka “<”'},
          {"key": "D", "text": 'Tanda pagar “#”'},
          {"key": "E", "text": 'Tanda dan “&”'}
        ],
        "image": ""
      },
      {
        "id": 7,
        "question":
            "Perhatikan pada script margin dibawah ini \nbody {\nmargin-top: 5px;\nmargin-bottom: 10px;\nmargin-left: 15px;\nmargin-right: 5px;\n}\nMaka script margin tersebut dapat kita ubah atau gabung menjadi ...",
        "answer": "D",
        "options": [
          {"key": "A", "text": 'margin : 5px 10px 5px 15px; '},
          {"key": "B", "text": 'margin : 5px 10px 15px 5px;'},
          {"key": "C", "text": 'margin : 5px 15px 10px 5px;'},
          {"key": "D", "text": 'margin : 5px 5px 10px 15px;'},
          {"key": "E", "text": 'margin : 5px 5px 15px 10px;'}
        ],
        "image": ""
      },
      {
        "id": 8,
        "question":
            "Kode CSS memiliki kemampauan untuk membangun sebuah layout website agar terlihat menarik. Script kode CSS untuk menambahkan warna latar menjadi merah untuk semua tag h1 adalah ...",
        "answer": "D",
        "options": [
          {"key": "A", "text": 'h1.all { backgroud-color:red }'},
          {"key": "B", "text": 'h1 {backcolor:red}'},
          {"key": "C", "text": 'all.h1 {backgroud-color:red}'},
          {"key": "D", "text": 'h1 {background-color:red;}'},
          {"key": "E", "text": 'h1 {bgcolor:red}'}
        ],
        "image": ""
      },
      {
        "id": 9,
        "question":
            "Agar terlihat menarik halaman website perlu ditambahkan sebuah animasi. Untuk membuat animasi teks berjalan dari kiri ke kanan dalam halaman web digunakan perintah adalah ...",
        "answer": "E",
        "options": [
          {"key": "A", "text": '<marquee> text berjalan </marquee>'},
          {
            "key": "B",
            "text":
                '<marquee><direction="right"> text berjalan </direction></marquee>'
          },
          {
            "key": "C",
            "text":
                '<marquee><direction="left"> text berjalan </direction></marquee>'
          },
          {
            "key": "D",
            "text": '<marquee direction="left"> text berjalan </marquee>'
          },
          {
            "key": "E",
            "text": '<marquee direction="right"> text berjalan </marquee>'
          }
        ],
        "image": ""
      },
      {
        "id": 10,
        "question":
            "Kode CSS memiliki kemampauan untuk membangun sebuah layout website agar terlihat menarik. Script kode CSS untuk menambahkan background image adalah ...",
        "answer": "D",
        "options": [
          {"key": "A", "text": '.bg {background_image:url(../image.png)}'},
          {"key": "B", "text": '.bg {bg-image:url(../image.png)}'},
          {"key": "C", "text": '.bg {background:image(../image.png)}	'},
          {"key": "D", "text": '.bg {background-image:url(../image.png)}'},
          {"key": "E", "text": '.bg {background.image:url(../image.png)}'}
        ],
        "image": ""
      },
    ];

    if (box.length <= 0) {
      for (Map<String, dynamic> quiz in dataCss) {
        CssQuiz cssQuiz = CssQuiz(
            id: quiz["id"] as int,
            answer: quiz["answer"] as String,
            options: quiz["options"] as List<Map<String, String>>,
            question: quiz["question"] as String,
            image: quiz["image"] as String);
        box.add(cssQuiz);
      }
    }
  }

  initializeJsQuiz() async {
    Box<JsQuiz> box = await Hive.openBox<JsQuiz>('js_quiz_box');
    List<Map<String, dynamic>> dataJs = [
      {
        "id": 1,
        "question":
            "Berikut ini adalah contoh nama-nama variabel yang valid menurut aturan Javascript, KECUALI …",
        "answer": "E",
        "options": [
          {"key": "A", "text": "angka1"},
          {"key": "B", "text": "\$nilai"},
          {"key": "C", "text": "nomor_telepon"},
          {"key": "D", "text": "namaDepan"},
          {"key": "E", "text": "break"}
        ],
        "image": ""
      },
      {
        "id": 2,
        "question": "Tipe data dari variabel str di atas adalah …",
        "answer": "B",
        "options": [
          {"key": "A", "text": "Null"},
          {"key": "B", "text": "String"},
          {"key": "C", "text": "Number"},
          {"key": "D", "text": "Boolean"},
          {"key": "E", "text": "Karakter"}
        ],
        "image": "assets/img/quizjs2.svg"
      },
      {
        "id": 3,
        "question": "Nilai yang disimpan oleh variabel z di atas adalah…",
        "answer": "B",
        "options": [
          {"key": "A", "text": "True"},
          {"key": "B", "text": "False"},
          {"key": "C", "text": "20"},
          {"key": "D", "text": "1010"},
          {"key": "E", "text": "10"}
        ],
        "image": "assets/img/quizjs3.svg"
      },
      {
        "id": 4,
        "question": """Perhatikan potongan kode berikut.
var numbers = [ 1 , 2 , ‘3’ , ‘empat’ ];
			
Untuk menampilkan elemen pertama dari array numbers pada sebuah kotak dialog, potongan kode yang perlu ditambahkan adalah…
""",
        "answer": "A",
        "options": [
          {"key": "A", "text": "alert(numbers[0])"},
          {"key": "B", "text": "alert(numbers[1])"},
          {"key": "C", "text": "document.write(numbers[0])"},
          {"key": "D", "text": "document.write(numbers[1])"},
          {"key": "E", "text": "prompt(numbers)"}
        ],
        "image": ""
      },
      {
        "id": 5,
        "question":
            "Jika variabel skor menyimpan nilai 78, maka hasil yang ditampilkan pada browser adalah …",
        "answer": "B",
        "options": [
          {"key": "A", "text": "alert(numbers[0])"},
          {"key": "B", "text": "alert(numbers[1])"},
          {"key": "C", "text": "document.write(numbers[0])"},
          {"key": "D", "text": "document.write(numbers[1])"},
          {"key": "E", "text": "prompt(numbers)"}
        ],
        "image": "assets/img/quizjs5.svg"
      },
      {
        "id": 6,
        "question": "Output yang dihasilkan dari for loop di atas adalah …",
        "answer": "B",
        "options": [
          {
            "key": "A",
            "text": """Belajar Javascript 
Belajar Javascript
"""
          },
          {
            "key": "B",
            "text": """Belajar Javascript
Belajar Javascript
Belajar Javascript
"""
          },
          {"key": "C", "text": "Belajar Javascript  Belajar Javascript"},
          {
            "key": "D",
            "text": "Belajar Javascript Belajar Javascript \nBelajar Javascript"
          },
          {"key": "E", "text": "Terjadi infinite looping"}
        ],
        "image": "assets/img/quizjs6.svg"
      },
      {
        "id": 7,
        "question":
            "Output yang dihasilkan dari potongan kode di atas adalah …",
        "answer": "A",
        "options": [
          {"key": "A", "text": "1"},
          {"key": "B", "text": "11"},
          {"key": "C", "text": "12"},
          {"key": "D", "text": "123"},
          {"key": "E", "text": "Infinite looping"}
        ],
        "image": "assets/img/quizjs7.svg"
      },
      {
        "id": 8,
        "question":
            "Perintah Javascript ini digunakan untuk mengakses elemen HTML berdasarkan nilai dari atribut name-nya, dan biasanya digunakan pada komponen form seperti radio atau checkbox. Method yang dimaksud adalah…",
        "answer": "D",
        "options": [
          {"key": "A", "text": "getById()"},
          {"key": "B", "text": "getByName()"},
          {"key": "C", "text": "getElementById()"},
          {"key": "D", "text": "getElementsByName()"},
          {"key": "E", "text": "getElementsByTagName()"}
        ],
        "image": ""
      },
      {
        "id": 9,
        "question":
            "Untuk menampilkan kotak dialog seperti ditunjukkan gambar di atas, potongan kode yang perlu ditambahkan adalah …",
        "answer": "B",
        "options": [
          {"key": "A", "text": "var x = prompt( “Berapa \ntinggi badan anda?” )"},
          {
            "key": "B",
            "text": "var x = prompt( “Berapa tinggi \nbadan anda?” , “meter” )"
          },
          {
            "key": "C",
            "text": "var x = prompt( Berapa tinggi \nbadan anda? , meter )"
          },
          {
            "key": "D",
            "text": "var x = alert(“Berapa tinggi \nbadan anda?” , “meter” )"
          },
          {"key": "E", "text": "var x = alert( Berapa tinggi \nbadan anda? )"}
        ],
        "image": "assets/img/quizjs9.svg"
      },
      {
        "id": 10,
        "question":
            "Potongan kode Javacript berikut yang tepat untuk mengubah warna background halaman web menjadi hijau adalah …",
        "answer": "B",
        "options": [
          {"key": "A", "text": "background-color: green"},
          {"key": "B", "text": 'document.body.style.backgroundColor \n= "green"'},
          {"key": "C", "text": "document.body.style.backgroundColor \n= green"},
          {"key": "D", "text": "document.body.style.backgroundColor \n(“green”)"},
          {"key": "E", "text": "document.body.style.backgroundColor \n(green)"}
        ],
        "image": ""
      },
    ];

    if (box.length <= 0) {
      for (Map<String, dynamic> quiz in dataJs) {
        JsQuiz jsQuiz = JsQuiz(
            id: quiz["id"] as int,
            answer: quiz["answer"] as String,
            options: quiz["options"] as List<Map<String, String>>,
            question: quiz["question"] as String,
            image: quiz["image"] as String);
        box.add(jsQuiz);
      }
    }
  }
}
