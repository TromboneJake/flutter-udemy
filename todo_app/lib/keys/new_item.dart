import 'package:flutter/material.dart';
import 'package:todo_app/todo.dart';
import 'package:todo_app/priority.dart';
import 'package:hive/hive.dart';

final taskBox = Hive.box<Todo>('tasks');

class NewItem extends StatefulWidget {
  const NewItem({super.key, required this.onAddItem});

  final void Function(Todo item) onAddItem;

  @override
  State<StatefulWidget> createState() {
    return _NewItemState();
  }
}

class _NewItemState extends State<NewItem> {
  final _itemNameController = TextEditingController();
  Priority? _selectedPriority; // Default priority

  void _submitItem() {
    var isDuplicate = false;

    for (var todo in taskBox.values) {
      if (todo.text == _itemNameController.text.trim()) {
        isDuplicate = true;
      }
    }

    if (_itemNameController.text.trim().isEmpty ||
        _selectedPriority == null ||
        isDuplicate) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog.adaptive(
          title: Text(
            'Invalid Input',
          ),
          content: Text(
            _itemNameController.text.trim().isEmpty || isDuplicate
                ? 'Task name cannot be empty or duplicate.'
                : 'Must select a task priority.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }
    widget.onAddItem(
      Todo(
        _itemNameController.text,
        _selectedPriority!,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _itemNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(24, 16, 24, keyboardSpace + 16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    textCapitalization: TextCapitalization.sentences,
                    controller: _itemNameController,
                    maxLength: 40,
                    decoration: InputDecoration(
                      label: Text('Task name'),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                // const SizedBox(width: 20),
                DropdownButton(
                    hint: Text('Task Priority'),
                    value: _selectedPriority,
                    items: Priority.values
                        .map(
                          (priority) => DropdownMenuItem(
                            value: priority,
                            child: Text(
                              priority.name.toUpperCase(),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }
                      setState(() {
                        _selectedPriority = value;
                      });
                    }),
              ],
            ),
            SizedBox(height: 48),
            // const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: _submitItem,
                  child: const Text('Add Task'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
