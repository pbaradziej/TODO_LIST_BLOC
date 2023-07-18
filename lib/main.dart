import 'package:flutter/material.dart';
import 'package:todo_list_bloc/injection_container.dart';
import 'package:todo_list_bloc/presentation/components/to_do_list.dart';

void main() {
  init();
  runApp(const ToDoListApp());
}

class ToDoListApp extends StatelessWidget {
  const ToDoListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
        useMaterial3: true,
      ),
      home: const ToDoList(),
    );
  }
}
