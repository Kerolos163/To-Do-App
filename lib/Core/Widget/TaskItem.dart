import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
        children: [
          CircleAvatar(
            radius: 40,
            child: Text(
              "2:59 PM",
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(width: 8),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Task Title",
                style: TextStyle(fontSize: 22),
              ),
              Text(
                "7 Oct, 2023",
                style: TextStyle(fontSize: 16,color: Colors.grey),
              ),
            ],
          )
        ],
      );
  }
}