import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:to_do_test/common/EmptyTodoMessage.dart';
import 'package:to_do_test/models/todos.dart';
import 'package:to_do_test/screens/add_todo.dart';
import 'package:to_do_test/screens/completed_todo.dart';
import 'package:to_do_test/screens/pending_todo.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/";

  const HomePage({super.key});
  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todos"),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 30),
            child: IconButton(
                key: const ValueKey("add_todo_btn"),
                onPressed: () {
                  context.go("/${AddTodoPage.routeName}");
                },
                tooltip: "Add Task",
                icon: const Icon(
                  Icons.add_task,
                  size: 24,
                )),
          ),
        ],
      ),
      body: loadMaterialBody(),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(
              Icons.home_filled,
              size: 32,
            ),
          ),
          BottomNavigationBarItem(
            label: "Completed",
            icon: Icon(
              Icons.done_all_rounded,
              size: 32,
            ),
          ),
          BottomNavigationBarItem(
            label: "Pending",
            icon: Icon(
              Icons.pending_actions_rounded,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }

  Widget loadMaterialBody() {
    return switch (_selectedIndex) {
      0 => Consumer<Todos>(
          builder: (context, value, child) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: value.todosList.isNotEmpty
                ? ListView.builder(
                    itemCount: value.todosList.length,
                    itemBuilder: ((context, index) =>
                        TodoListTile(value.todosList[index], index)),
                  )
                : const EmptyTodoMessage(emptyMessage: "Empty Todo List"),
          ),
        ),
      1 => const CompletedTodoPage(),
      2 => const PendingTodoPage(),
      _ => const Center(
          child: Text("Not found"),
        ),
    };
  }
}

class TodoListTile extends StatelessWidget {
  const TodoListTile(this.todo, this.index, {super.key});

  final Todo todo;
  final int index;

  @override
  Widget build(BuildContext context) {
    var todos = Provider.of<Todos>(context);
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      color: const Color.fromARGB(80, 186, 104, 200),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            context.go("/update_todo/$index");
          },
          child: ListTile(
            leading: Checkbox(
                key: ValueKey("checkbox_$index"),
                value: todo.completed,
                onChanged: (value) {
                  todos.toggleComplete(index);
                }),
            title: Text(
              todo.title,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                decoration: todo.completed ? TextDecoration.lineThrough : null,
                decorationThickness: todo.completed ? 2.85 : null,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
                onPressed: () {
                  todos.delete(index);
                },
                icon: const Icon(Icons.delete)),
          ),
        ),
      ),
    );
  }
}
