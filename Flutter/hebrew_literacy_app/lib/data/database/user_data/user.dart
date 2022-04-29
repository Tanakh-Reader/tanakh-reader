import 'package:hive/hive.dart';
part 'user.g.dart';

@HiveType(typeId: 4)
enum ReadingLevel {
  @HiveField(0)
  beginner,
  @HiveField(1)
  elementary,
  @HiveField(2)
  intermediate,
  @HiveField(3)
  advanced,
  @HiveField(4)
  expert
}

@HiveType(typeId: 3)
class User extends HiveObject {
  @HiveField(0)
  String firstName = '';
  @HiveField(1)
  String lastName = '';
  @HiveField(2)
  String email = '';
  @HiveField(3)
  ReadingLevel readingLevel = ReadingLevel.elementary;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.readingLevel
  });
}
