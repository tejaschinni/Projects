import 'package:hive/hive.dart';

part 'userData.g.dart';

@HiveType(typeId: 0)
class UserData extends HiveObject {
  @HiveField(0)
  late final String name;

  @HiveField(1)
  late final String password;

  @HiveField(2)
  late final String email;

  @HiveField(3)
  late final int number;

  @HiveField(4)
  late final String profession;

  UserData(
      {required this.name,
      required this.password,
      required this.email,
      required this.number,
      required this.profession});
}
