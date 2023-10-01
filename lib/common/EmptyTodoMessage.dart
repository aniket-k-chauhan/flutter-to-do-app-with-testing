import 'package:flutter/material.dart';

class EmptyTodoMessage extends StatelessWidget {
  const EmptyTodoMessage({
    super.key,
    required this.emptyMessage,
  });

  final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      emptyMessage,
      style: const TextStyle(fontSize: 24),
    ));
  }
}
