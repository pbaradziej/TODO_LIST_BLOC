import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_bloc/injection_container.dart';
import 'package:todo_list_bloc/presentation/cubit/home/home_cubit.dart';
import 'package:todo_list_bloc/todo_app.dart';

void main() {
  init();
  runApp(const ToDoListApp());
}

class ToDoListApp extends StatelessWidget {
  const ToDoListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (_) => sl<HomeCubit>(),
      child: const TodoApp(),
    );
  }
}
