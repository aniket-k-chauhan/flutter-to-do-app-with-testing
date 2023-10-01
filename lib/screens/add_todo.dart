import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:to_do_test/models/todos.dart';
import 'package:to_do_test/screens/home.dart';

class AddTodoPage extends StatelessWidget {
  const AddTodoPage({super.key});

  static const routeName = "add_todo";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Todo"),
      ),
      body: const AddTodoForm(),
    );
  }
}

class AddTodoForm extends StatefulWidget {
  const AddTodoForm({super.key});

  @override
  State<AddTodoForm> createState() {
    return _AddTodoFormState();
  }
}

class _AddTodoFormState extends State<AddTodoForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var todos = Provider.of<Todos>(context);

    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            TextFormField(
              key: const ValueKey("task_title_textformfield"),
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
              key: const ValueKey("submit_btn"),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  todos.add(Todo(title: _titleController.text));
                  context.go(HomePage.routeName);
                }
              },
              child: const Text("Submit"),
            )
          ],
        ),
      ),
    );
  }
}
