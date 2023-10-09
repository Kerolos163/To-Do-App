import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  const TaskItem(
      {super.key,
      required this.taskmodel,
      this.doneTask,
      this.archived,
      required this.dismissiblekey,
      this.onDismissed});
  final Map taskmodel;
  final void Function()? doneTask;
  final void Function()? archived;
  final String dismissiblekey;
  final void Function(DismissDirection)? onDismissed;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(dismissiblekey),
      onDismissed: onDismissed,
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            child: Text(
              taskmodel["time"],
              style: const TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  taskmodel["title"],
                  style: const TextStyle(fontSize: 22),
                ),
                Text(
                  taskmodel["date"],
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
          doneTask != null
              ? IconButton(
                  onPressed: doneTask,
                  icon: const Icon(
                    Icons.done,
                    color: Colors.green,
                    size: 30,
                  ),
                )
              : Container(),
          const SizedBox(width: 16),
          archived != null
              ? IconButton(
                  onPressed: archived,
                  icon: const Icon(
                    Icons.archive_rounded,
                    color: Colors.purple,
                    size: 30,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
