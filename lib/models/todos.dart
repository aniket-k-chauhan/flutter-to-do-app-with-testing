import 'package:flutter/material.dart';

class Todos extends ChangeNotifier {
  final List<Todo> _todos = [
    Todo(title: "default todo 1 longgggggggggggggg"),
    Todo(title: "default todo 2"),
    Todo(title: "default todo 3"),
  ];

  List<Todo> get todosList => _todos;
  List<Todo> get todosCompletedList =>
      _todos.where((todo) => todo.completed).toList();
  List<Todo> get todosPendingList =>
      _todos.where((todo) => !todo.completed).toList();

  void add(Todo todo) {
    _todos.add(todo);
    notifyListeners();
  }

  void delete(int index) {
    _todos.removeAt(index);
    notifyListeners();
  }

  void toggleComplete(int index) {
    _todos[index].completed = !_todos[index].completed;
    notifyListeners();
  }

  void update(int index, Todo todo) {
    _todos[index] = todo;
    notifyListeners();
  }
}

class Todo {
  final String title;
  bool completed;

  Todo({required this.title, this.completed = false});
}
