import 'package:hive/hive.dart';

part 'css_course_db.g.dart';

@HiveType(typeId: 2)
class CssCourse {
  CssCourse(
      {required this.id, required this.title, required this.description, required this.progressMateri, required this.progressInteraktif});

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3, defaultValue: 0)
  int progressMateri;
  @HiveField(4, defaultValue: [0])
  List<int> progressInteraktif;
}
