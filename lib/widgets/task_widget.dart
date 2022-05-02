import 'package:flutter/material.dart';

class TaskWidget extends StatelessWidget {
  final String task;
  final Color color;

  const TaskWidget({Key? key, required this.task, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height / 14,
      decoration: const BoxDecoration(
        color: Color(0xFFedf0f8),
      ),
      child: Center(
        child: Text(
          task,
          style: TextStyle(color: color, fontSize: 20),
        ),
      ),
    );
  }
}
