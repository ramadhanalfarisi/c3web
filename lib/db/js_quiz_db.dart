import 'package:hive/hive.dart';

part 'js_quiz_db.g.dart';

@HiveType(typeId: 6)
class JsQuiz {
  JsQuiz(
      {required this.id,
      required this.question,
      required this.answer,
      required this.options,
      this.image});

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String question;
  @HiveField(2)
  final String answer;
  @HiveField(3)
  final List<Map<String, String>> options;
  @HiveField(4, defaultValue: "")
  String? image;
}
