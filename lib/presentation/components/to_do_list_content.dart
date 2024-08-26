import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_bloc/domain/entities/to_do_item.dart';
import 'package:todo_list_bloc/l10n/l10n.dart';
import 'package:todo_list_bloc/presentation/components/to_do_list_view.dart';
import 'package:todo_list_bloc/presentation/cubit/to_do/to_do_cubit.dart';

class ToDoListContent extends StatefulWidget {
  const ToDoListContent({Key? key}) : super(key: key);

  @override
  State<ToDoListContent> createState() => _ToDoListContentState();
}

class _ToDoListContentState extends State<ToDoListContent> {
  late ToDoCubit toDoCubit;
  late TextEditingController adderToDoController;

  @override
  void initState() {
    super.initState();
    toDoCubit = context.read();
    adderToDoController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        adderTextField(),
        const SizedBox(height: 10),
        const ToDoListView(
          isCompletedTab: false,
        ),
      ],
    );
  }

  Widget adderTextField() {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: adderToDoController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: context.translations.tab_add_placeholder,
            ),
            onSubmitted: (_) {
              final String text = adderToDoController.text;
              final ToDoItem toDoItem = ToDoItem(text: text);
              toDoCubit.addToDoItem(toDoItem);
              adderToDoController.clear();
            },
          ),
        ),
        IconButton(
          onPressed: () {
            final String text = adderToDoController.text;
            final ToDoItem toDoItem = ToDoItem(text: text);
            toDoCubit.addToDoItem(toDoItem);
            adderToDoController.clear();
          },
          icon: const Icon(
            Icons.add,
          ),
        ),
      ],
    );
  }
}
