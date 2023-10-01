import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_test/common/EmptyTodoMessage.dart';
import 'package:to_do_test/models/todos.dart';

class CompletedTodoPage extends StatelessWidget {
  const CompletedTodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Todos>(
      builder: (context, value, child) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: value.todosCompletedList.isNotEmpty
            ? ListView.builder(
                itemCount: value.todosCompletedList.length,
                itemBuilder: ((context, index) =>
                    TodoListTile(value.todosCompletedList[index], index)),
              )
            : const EmptyTodoMessage(
                emptyMessage: "No Completed Todo",
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
            style: const TextStyle(
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
