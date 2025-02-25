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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Todo && other.text == text && other.priority == priority;
  }

  @override
  int get hashCode => text.hashCode ^ priority.hashCode;
}
