import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_test/common/EmptyTodoMessage.dart';
import 'package:to_do_test/models/todos.dart';

class PendingTodoPage extends StatelessWidget {
  const PendingTodoPage({super.key});

  static const routeName = "pending";

  @override
  Widget build(BuildContext context) {
    return Consumer<Todos>(
      builder: (context, value, child) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: value.todosPendingList.isNotEmpty
            ? ListView.builder(
                itemCount: value.todosPendingList.length,
                itemBuilder: ((context, index) =>
                    TodoListTile(value.todosPendingList[index], index)),
              )
            : const EmptyTodoMessage(
                emptyMessage: "No Pending Todo",
              ),
      ),
    );
  }
}

class TodoListTile extends StatelessWidget {
  const TodoListTile(this.todo, this.index, {super.key});

  final Todo todo;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      color: const Color.fromARGB(80, 186, 104, 200),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Text(
            todo.title,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
