import 'package:hive/hive.dart';
import 'package:todo_app/priority.dart';

part 'todo.g.dart'; // Hive Code Generation

@HiveType(typeId: 0) // Unique typeId for the adapter
class Todo extends HiveObject {
  @HiveField(0)
  final String text;

  @HiveField(1)
  final Priority priority;

  Todo(this.text, this.priority);
}
