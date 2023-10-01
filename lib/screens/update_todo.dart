import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:to_do_test/models/todos.dart';
import 'package:to_do_test/screens/home.dart';

class UpdateTodoPage extends StatelessWidget {
  const UpdateTodoPage({super.key, required this.index});

  final int index;

  static const routeName = "update_todo/:todo_index";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Todo"),
      ),
      body: UpdateTodoForm(
        index: index,
      ),
    );
  }
}

class UpdateTodoForm extends StatefulWidget {
  const UpdateTodoForm({super.key, required this.index});

  final int index;

  @override
  State<UpdateTodoForm> createState() {
    return _UpdateTodoFormState();
  }
}

class _UpdateTodoFormState extends State<UpdateTodoForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;

  @override
  Widget build(BuildContext context) {
    var todos = Provider.of<Todos>(context);
    _titleController =
        TextEditingController(text: todos.todosList[widget.index].title);

    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            TextFormField(
              key: const ValueKey("update_task_title_textformfield"),
              controller: _titleController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter task title";
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: "Task Title",
                hintText: "Enter Task Title",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 186, 104, 200), width: 1.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.red[200]!, width: 1.5),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.red[200]!, width: 1.5),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              key: const ValueKey("update_btn"),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  todos.update(
                      widget.index, Todo(title: _titleController.text));
                  context.go(HomePage.routeName);
                }
              },
              child: const Text("Update"),
            )
          ],
        ),
      ),
    );
  }
}
