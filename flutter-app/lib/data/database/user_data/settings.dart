import 'package:hive/hive.dart';
part 'settings.g.dart';


@HiveType(typeId: 6)
class Settings extends HiveObject {

  @HiveField(0)
  late String theme;

  @HiveField(1)
  late int readingTextSize;

  @HiveField(2)
  late String readingTextFont;

  @HiveField(3)
  late bool showPhrase;

  @HiveField(4)
  late bool showClause;

  @HiveField(5)
  late bool showVerse;

  @HiveField(6)
  late bool showParagraph;
}
