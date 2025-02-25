import 'package:flutter/material.dart';
import 'package:todo_app/todo.dart';
import 'package:todo_app/priority.dart';
import 'package:hive/hive.dart';

final taskBox = Hive.box<Todo>('tasks');

class EditItem extends StatefulWidget {
  const EditItem({super.key, required this.item, required this.onEditItem});

  final void Function(Todo originalItem, Todo item) onEditItem;
  final Todo item;

  @override
  State<StatefulWidget> createState() {
    return _EditItemState();
  }
}

class _EditItemState extends State<EditItem> {
  late Todo originalTask;
  final _itemNameController = TextEditingController();
  Priority? _selectedPriority;
  late String originalText;

  @override
  void initState() {
    super.initState();
    originalTask = widget.item;
    originalText = originalTask.text;
    _itemNameController.text = originalText;
    _selectedPriority = widget.item.priority;
  }

  void _submitEditedItem() {
    var isDuplicate = false;
    var inputtedText = _itemNameController.text.trim();

    for (var todo in taskBox.values) {
      if (todo.text == inputtedText && inputtedText != originalText) {
        isDuplicate = true;
      }
    }

    if (inputtedText.trim().isEmpty || isDuplicate) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog.adaptive(
          title: Text('Invalid Input'),
          content: Text('Task name cannot be empty or duplicate.'),
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
    widget.onEditItem(
      Todo(
        originalTask.text,
        originalTask.priority,
      ),
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
    return AlertDialog.adaptive(
      title: Text(
        'Edit Task',
      ),
      content: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              textCapitalization: TextCapitalization.sentences,
              controller: _itemNameController,
              maxLength: 40,
              decoration: InputDecoration(
                label: Text('Task name'),
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
                  onPressed: _submitEditedItem,
                  child: const Text('Edit Task'),
                ),
              ],
            ),
          ],
        ),
      ),
      // actions: [TextButton(onPressed: () {Navigator.pop(context);}, child: const Text(data))]
    );
  }
}
