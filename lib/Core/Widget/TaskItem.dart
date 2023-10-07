import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.taskmodel});
  final Map taskmodel;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 40,
          child: Text(
            taskmodel["time"],
            style: const TextStyle(fontSize: 18),
          ),
        ),
        const SizedBox(width: 8),
        Column(
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
        )
      ],
    );
  }
}
