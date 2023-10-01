import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:to_do_test/models/todos.dart';
import 'package:to_do_test/screens/home.dart';

late Todos todos;

void main() {
  group("Home Page Widget Test", () {
    testWidgets("Testing if AppBar is shows up", (tester) async {
      await tester.pumpWidget(_createHomeScreen());
      await tester.pumpAndSettle();
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byIcon(Icons.add_task), findsOneWidget);
    });

    testWidgets("Testing Scrolling", (tester) async {
      await tester.pumpWidget(_createHomeScreen());
      addTooManyTodos();
      await tester.pumpAndSettle();
      expect(find.text("new todo 1"), findsOneWidget);
      await tester.fling(find.byType(ListView), Offset(0, -200), 3000);
      await tester.pumpAndSettle();
      expect(find.text("new todo 1"), findsNothing);
    });

    testWidgets("Testing if todos ListView shows up", (tester) async {
      await tester.pumpWidget(_createHomeScreen());
      addTodos();
      await tester.pumpAndSettle();
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets("Testing Delete Button", (tester) async {
      await tester.pumpWidget(_createHomeScreen());
      addTodos();
      await tester.pumpAndSettle();
      var totalTodos = tester.widgetList(find.byIcon(Icons.delete)).length;
      await tester.tap(find.byIcon(Icons.delete).first);
      await tester.pumpAndSettle();
      expect(tester.widgetList(find.byIcon(Icons.delete)).length,
          lessThan(totalTodos));
    });

    testWidgets("Testing Checkbox Toggle", (tester) async {
      await tester.pumpWidget(_createHomeScreen());
      addTodos();
      await tester.pumpAndSettle();
      var prevFirstCheckbox = tester
          .firstWidget<Checkbox>(find.byKey(const ValueKey("checkbox_1")));
      expect(prevFirstCheckbox.value, false);
      await tester.tap(find.byKey(const ValueKey("checkbox_1")));
      await tester.pumpAndSettle();
      var afterFirstCheckbox = tester
          .firstWidget<Checkbox>(find.byKey(const ValueKey("checkbox_1")));
      expect(afterFirstCheckbox.value, true);
    });
  });
}

Widget _createHomeScreen() {
  return ChangeNotifierProvider<Todos>(
    create: (context) {
      todos = Todos();
      return todos;
    },
    child: const MaterialApp(
      home: HomePage(),
    ),
  );
}

void addTodos() {
  for (var i = 0; i < 3; i++) {
    todos.add(Todo(title: "new todo $i"));
  }
}

void addTooManyTodos() {
  for (var i = 0; i < 20; i++) {
    todos.add(Todo(title: "new todo $i"));
  }
}
