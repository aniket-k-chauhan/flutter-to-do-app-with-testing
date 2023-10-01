import "package:test/test.dart";
import "package:to_do_test/models/todos.dart";

void main() {
  group("Todo App Provider", () {
    var todos = Todos();
    test("A new todo should be added", () {
      var newTodo = Todo(title: "new todo");
      final prevLength = todos.todosList.length;
      todos.add(newTodo);
      expect(todos.todosList.length, greaterThan(prevLength));
    });

    test("A todo should be deleted", () {
      var newTodo = Todo(title: "new todo");
      todos.add(newTodo);
      final prevLength = todos.todosList.length;
      todos.delete(prevLength - 1);
      expect(todos.todosList.length, lessThan(prevLength));
    });

    test("A todo should be updated", () {
      var newTodo = Todo(title: "new todo");
      todos.add(newTodo);
      final newTodoIndex = todos.todosList.length - 1;
      final newUpdatedTodo = Todo(title: "new todo updated");
      todos.update(newTodoIndex, newUpdatedTodo);
      expect(todos.todosList[newTodoIndex].title, equals("new todo updated"));
    });

    test("Mark Todo should be completed", () {
      var newTodo = Todo(title: "new todo");
      todos.add(newTodo);
      final newTodoIndex = todos.todosList.length - 1;
      todos.toggleComplete(newTodoIndex);
      expect(todos.todosList[newTodoIndex].completed, true);
    });
  });
}
