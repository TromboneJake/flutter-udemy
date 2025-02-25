import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/keys/checkable_todo_item.dart';
import 'package:todo_app/keys/new_item.dart';
import 'package:todo_app/keys/edit_item.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/todo.dart';
import 'package:todo_app/priority.dart';

final taskBox = Hive.box<Todo>('tasks');
final userBox = Hive.box('userInfo');
final checkedTasksBox = Hive.box('checkedTasksBox');

class Keys extends StatefulWidget {
  const Keys({super.key});

  @override
  State<Keys> createState() {
    return _KeysState();
  }
}

class _KeysState extends State<Keys> {
  var _order = 'desc';

  final List<Todo> _todos = taskBox.values.cast<Todo>().toList();

  @override
  void initState() {
    super.initState();
    if (userBox.get('isFirstRun') == true) {
      final defaultTodo = Todo(
        'This is a sample todo - swipe to delete!',
        Priority.normal,
      );
      _addItem(defaultTodo);
      userBox.put('isFirstRun', false);
    }
  }

  List<Todo> get _orderedTodos {
    final sortedTodos = List.of(_todos);
    sortedTodos.sort((a, b) {
      final priorityComparison = b.priority.index.compareTo(a.priority.index);
      return _order == 'asc' ? priorityComparison : -priorityComparison;
    });
    return sortedTodos;
  }

  void _changeOrder() {
    setState(() {
      _order = _order == 'asc' ? 'desc' : 'asc';
    });
  }

  void _openAddItemOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (modalContext) => NewItem(onAddItem: _addItem),
    );
  }

  void _addItem(Todo item) {
    setState(() {
      _todos.add(item);
    });
    taskBox.add(item);
  }

  void _openEditItemOverlay(Todo todo) {
    showAdaptiveDialog(
      context: context,
      builder: (modalContext) => EditItem(item: todo, onEditItem: _editItem),
    );
  }

  void _editItem(Todo originalItem, Todo item) {
    final index = _todos.indexOf(originalItem);
    final isDone = checkedTasksBox.get(originalItem.text) ?? false;
    if (index != -1) {
      setState(() {
        _todos[index] = item;
      });
      taskBox.putAt(index, item);
      checkedTasksBox.delete(originalItem.text);
      checkedTasksBox.put(item.text, isDone);
    }
  }

  void _removeItem(Todo item) {
    final itemIndex = _todos.indexOf(item);
    final bool isDone = checkedTasksBox.get(item.text) ?? false;
    setState(() {
      _todos.remove(item);
    });
    taskBox.deleteAt(itemIndex);
    checkedTasksBox.delete(item.text);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Task deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            HapticFeedback.vibrate();
            setState(() {
              _todos.insert(itemIndex, item);
            });
            taskBox.add(item);
            checkedTasksBox.put(item.text, isDone);
          },
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Center(
      child: Text('No tasks found. Start adding some!'),
    );

    if (_todos.isNotEmpty) {
      mainContent = Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: _changeOrder,
              icon: Icon(
                _order == 'asc' ? Icons.arrow_upward : Icons.arrow_downward,
              ),
              label: Text(
                '${_order == 'asc' ? 'Low' : 'High'} to ${_order == 'asc' ? 'High' : 'Low'}',
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                for (final todo in _orderedTodos)
                  Dismissible(
                    // DELETE SWIPE RIGHT
                    background: Container(
                      color: Theme.of(context)
                          .colorScheme
                          .errorContainer
                          .withValues(alpha: 0.75),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 20),
                      child: Icon(
                        Icons.delete,
                        color: Theme.of(context)
                            .colorScheme
                            .onErrorContainer
                            .withValues(alpha: 0.5),
                        size: 36,
                      ),
                    ),
                    // DELETE SWIPE LEFT
                    secondaryBackground: Container(
                      color: Theme.of(context)
                          .colorScheme
                          .errorContainer
                          .withValues(alpha: 0.75),
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20),
                      child: Icon(
                        Icons.delete,
                        color: Theme.of(context)
                            .colorScheme
                            .onErrorContainer
                            .withValues(alpha: 0.5),
                        size: 36,
                      ),
                    ),
                    key: Key(todo.text),
                    onDismissed: (direction) {
                      HapticFeedback.vibrate();
                      _removeItem(todo);
                    },
                    child: GestureDetector(
                      onLongPress: () {
                        HapticFeedback.vibrate();
                        _openEditItemOverlay(todo);
                      },
                      child: CheckableTodoItem(
                        key: ValueKey(todo.text),
                        todo.text,
                        todo.priority,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text(
              'To',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Do',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
      body: mainContent,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          HapticFeedback.vibrate();
          _openAddItemOverlay();
        },
        label: Text('Add Task'),
        icon: const Icon(Icons.add),
        tooltip: 'Click to add a task...',
        splashColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
