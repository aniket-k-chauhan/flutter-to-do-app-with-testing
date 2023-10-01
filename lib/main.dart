import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:to_do_test/models/todos.dart';
import 'package:to_do_test/routes/routes.dart' as router;

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Todos>(
      create: (context) => Todos(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: "Todo App",
        theme: ThemeData.dark(useMaterial3: true),
        routerConfig: router.routes,
      ),
    );
  }
}
