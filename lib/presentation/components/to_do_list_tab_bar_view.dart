import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_bloc/presentation/components/to_do_list_content.dart';
import 'package:todo_list_bloc/presentation/components/to_do_list_view.dart';
import 'package:todo_list_bloc/presentation/cubit/to_do_cubit.dart';

class ToDoListTabBarView extends StatefulWidget {
  const ToDoListTabBarView({Key? key}) : super(key: key);

  @override
  State<ToDoListTabBarView> createState() => _ToDoListTabBarViewState();
}

class _ToDoListTabBarViewState extends State<ToDoListTabBarView> {
  late ToDoCubit toDoCubit;
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    toDoCubit = context.read();
    toDoCubit.initializeToDoItems();
  }

  @override
  Widget build(BuildContext context) {
    _controller = DefaultTabController.of(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: buildDesktopTabBar(context),
    );
  }

  Widget buildDesktopTabBar(BuildContext context) {
    return TabBarView(
      controller: _controller,
      children: <Widget>[
        const ToDoListContent(),
        const ToDoListView(
          isCompletedTab: true,
        ),
      ],
    );
  }
}
