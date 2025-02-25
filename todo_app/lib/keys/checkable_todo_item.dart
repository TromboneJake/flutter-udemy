import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/priority.dart';
import 'package:hive/hive.dart';

final checkedTasksBox = Hive.box('checkedTasksBox');

class CheckableTodoItem extends StatefulWidget {
  const CheckableTodoItem(this.text, this.priority, {super.key});

  final String text;
  final Priority priority;

  @override
  State<CheckableTodoItem> createState() => _CheckableTodoItemState();
}

class _CheckableTodoItemState extends State<CheckableTodoItem> {
  late bool _done;

  @override
  void initState() {
    super.initState();
    _done = checkedTasksBox.get(widget.text) ?? false;
  }

  void _setDone(bool? isCheckedParam) {
    HapticFeedback.vibrate();
    setState(() {
      _done = isCheckedParam ?? false;
    });
    checkedTasksBox.put(widget.text, _done);

    bool allDone = true;
    for (var key in checkedTasksBox.keys) {
      if (checkedTasksBox.get(key) != true) {
        allDone = false;
        break;
      }
    }
    if (allDone) {
      // Perform an action if all tasks are done
    }
  }

  @override
  Widget build(BuildContext context) {
    var icon = Icons.low_priority;

    if (widget.priority == Priority.urgent) {
      icon = Icons.priority_high;
    }

    if (widget.priority == Priority.normal) {
      icon = Icons.list;
    }

    return InkWell(
      onTap: () => _setDone(!_done),
      child: Container(
        padding: const EdgeInsets.all(8),
        // Set backgroung color if high priority
        color: icon == Icons.priority_high
            ? Theme.of(context)
                .colorScheme
                .inversePrimary
                .withValues(alpha: 0.5)
            : Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox(
              value: checkedTasksBox.get(widget.text) ?? false,
              onChanged: _setDone,
            ),
            const SizedBox(width: 6),
            Icon(
              icon,
              color: _done
                  ? Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.5)
                  : Theme.of(context).colorScheme.onSurface,
            ),
            const SizedBox(width: 12),
            Text(
              widget.text,
              style: _done
                  ? TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.5),
                      decoration: TextDecoration.lineThrough,
                      decorationColor: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.5),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
