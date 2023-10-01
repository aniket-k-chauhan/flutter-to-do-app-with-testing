import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_test/main.dart';

void main() {
  group("Testing App", () {
    testWidgets("Test default todo in Home, Completed and Pending Screens",
        (tester) async {
      await tester.pumpWidget(const TodoApp());
      await tester.pumpAndSettle();

      const defaultTotalTodoListLength = 3;
      final completedIcon = find.byIcon(Icons.done_all_rounded);
      final pendingIcon = find.byIcon(Icons.pending_actions_rounded);

      expect(tester.widgetList(find.byType(Card)).length,
          equals(defaultTotalTodoListLength));

      await tester.tap(completedIcon);
      await tester.pumpAndSettle();

      expect(find.text("No Completed Todo"), findsOneWidget);

      await tester.tap(pendingIcon);
      await tester.pumpAndSettle();

      expect(tester.widgetList(find.byType(Card)).length,
          equals(defaultTotalTodoListLength));
    });

    testWidgets("Test Add, Update and Delete operations", (tester) async {
      await tester.pumpWidget(const TodoApp());
      await tester.pumpAndSettle();

      final prevTodosLength = tester.widgetList(find.byType(Card)).length;

      await tester.tap(find.byKey(const ValueKey("add_todo_btn")));
      await tester.pumpAndSettle();

      const newTodoTitle = "todo add test";

      await tester.enterText(
          find.byKey(const ValueKey("task_title_textformfield")), newTodoTitle);
      await tester.tap(find.byKey(const ValueKey("submit_btn")));
      await tester.pumpAndSettle();

      expect(tester.widgetList(find.byType(Card)).length,
          greaterThan(prevTodosLength));

      await tester.tap(find.byType(ListTile).last);
      await tester.pumpAndSettle();

      final updateTaskTitle = tester.firstWidget<TextFormField>(
          find.byKey(const ValueKey("update_task_title_textformfield")));
      expect(updateTaskTitle.controller?.text, newTodoTitle);

      const updateTodoTitle = "todo update test";

      await tester.enterText(
          find.byKey(const ValueKey("update_task_title_textformfield")),
          updateTodoTitle);
      await tester.tap(find.byKey(const ValueKey("update_btn")));
      await tester.pumpAndSettle();

      expect(find.text(updateTodoTitle), findsOneWidget);

      await tester.tap(find.byIcon(Icons.delete).last);
      await tester.pumpAndSettle();

      expect(
          tester.widgetList(find.byType(Card)).length, equals(prevTodosLength));
    });

    testWidgets(
        "Test mark task as complete should reflect on Completed and Pending Screens",
        (tester) async {
      await tester.pumpWidget(const TodoApp());
      await tester.pumpAndSettle();

      const defaultTotalTodoListLength = 3;

      await tester.tap(find.byType(Checkbox).first);

      await tester.tap(find.byIcon(Icons.done_all_rounded));
      await tester.pumpAndSettle();
      expect(tester.widgetList(find.byType(Card)).length, equals(1));

      await tester.tap(find.byIcon(Icons.pending_actions_rounded));
      await tester.pumpAndSettle();
      expect(tester.widgetList(find.byType(Card)).length,
          equals(defaultTotalTodoListLength - 1));
    });
  });
}
