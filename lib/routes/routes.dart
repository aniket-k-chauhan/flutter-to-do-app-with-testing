import 'package:go_router/go_router.dart';
import 'package:to_do_test/screens/add_todo.dart';
import 'package:to_do_test/screens/home.dart';
import 'package:to_do_test/screens/update_todo.dart';

final routes = GoRouter(
  routes: [
    GoRoute(
      path: HomePage.routeName,
      builder: (context, state) {
        return HomePage();
      },
      routes: [
        GoRoute(
          path: AddTodoPage.routeName,
          builder: (context, state) {
            return AddTodoPage();
          },
        ),
        GoRoute(
          path: UpdateTodoPage.routeName,
          builder: (context, state) {
            return UpdateTodoPage(
              index: int.parse(state.pathParameters["todo_index"]!),
            );
          },
        ),
      ],
    ),
  ],
);
