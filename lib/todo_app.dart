import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_bloc/l10n/generated/translations.dart';
import 'package:todo_list_bloc/presentation/components/to_do_list.dart';
import 'package:todo_list_bloc/presentation/cubit/home/home_cubit.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  late HomeCubit homeCubit;

  @override
  void initState() {
    super.initState();
    homeCubit = context.read();
    homeCubit.initializeHome();
  }

  @override
  Widget build(BuildContext context) {
    final Locale locale = context.select((HomeCubit cubit) => cubit.state.locale);

    return MaterialApp(
      localizationsDelegates: Translations.localizationsDelegates,
      supportedLocales: Translations.supportedLocales,
      locale: locale,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
        useMaterial3: true,
      ),
      home: const ToDoList(),
    );
  }
}
