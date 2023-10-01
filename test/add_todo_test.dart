import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:provider/provider.dart";

import "package:to_do_test/models/todos.dart";
import "package:to_do_test/screens/add_todo.dart";

late Todos todos;

void main() {
  group("AddTodo Page Widget Test", () {
    testWidgets("Testing if AddTodo Page is shows up with all widgets",
        (tester) async {
      await tester.pumpWidget(_createAddTodoScreen());
      await tester.pumpAndSettle();
      expect(find.text("Add Todo"), findsOneWidget);
      expect(find.byKey(const ValueKey("task_title_textformfield")),
          findsOneWidget);
      expect(find.byKey(const ValueKey("submit_btn")), findsOneWidget);
    });

    testWidgets("Testing empty task title shouldn't be submitted",
        (tester) async {
      await tester.pumpWidget(_createAddTodoScreen());
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey("submit_btn")));
      await tester.pumpAndSettle();
      expect(find.text("Please enter task title"), findsOneWidget);
    });
  });
}

Widget _createAddTodoScreen() {
  return ChangeNotifierProvider<Todos>(
    create: (context) {
      todos = Todos();
      return todos;
    },
    child: const MaterialApp(
      home: AddTodoPage(),
    ),
  );
}
