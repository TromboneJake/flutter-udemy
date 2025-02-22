import 'package:hive/hive.dart';

part 'priority.g.dart'; // Required for Hive's generated adapter

@HiveType(typeId: 1) // Unique typeId (must be different from Todo)
enum Priority {
  @HiveField(0)
  urgent,

  @HiveField(1)
  normal,

  @HiveField(2)
  low,
}
