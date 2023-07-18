import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_bloc/injection_container.dart';
import 'package:todo_list_bloc/presentation/components/to_do_list_app_bar.dart';
import 'package:todo_list_bloc/presentation/components/to_do_list_tab_bar_view.dart';
import 'package:todo_list_bloc/presentation/cubit/to_do_cubit.dart';

class ToDoList extends StatelessWidget {
  const ToDoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: const ToDoListAppBar(),
        body: BlocProvider<ToDoCubit>(
          create: (_) => sl<ToDoCubit>(),
          child: const ToDoListTabBarView(),
        ),
      ),
    );
  }
}
