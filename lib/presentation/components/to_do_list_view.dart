import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_bloc/domain/entities/to_do_item.dart';
import 'package:todo_list_bloc/presentation/components/edit_to_do_item_dialog.dart';
import 'package:todo_list_bloc/presentation/cubit/to_do_cubit.dart';

class ToDoListView extends StatefulWidget {
  final bool isCompletedTab;

  const ToDoListView({
    required this.isCompletedTab,
    Key? key,
  }) : super(key: key);

  @override
  State<ToDoListView> createState() => _ToDoListViewState();
}

class _ToDoListViewState extends State<ToDoListView> {
  late ToDoCubit toDoCubit;
  late bool isCompletedTab;

  @override
  void initState() {
    super.initState();
    toDoCubit = context.read();
    isCompletedTab = widget.isCompletedTab;
  }

  @override
  Widget build(BuildContext context) {
    final ToDoState state = context.select<ToDoCubit, ToDoState>(getToDoState);
    final ToDoStatus status = state.status;
    if (status == ToDoStatus.initial) {
      return const CircularProgressIndicator();
    }

    final List<ToDoItem> toDoItems = state.toDoItems;
    final List<ToDoItem> filteredItems = toDoItems.where((ToDoItem item) => item.isComplete == isCompletedTab).toList();

    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: filteredItems.length,
      itemBuilder: (BuildContext context, int index) {
        return showToDoItems(filteredItems, index);
      },
    );
  }

  ToDoState getToDoState(ToDoCubit cubit) {
    return cubit.state;
  }

  Widget showToDoItems(List<ToDoItem> toDoItems, int index) {
    final ToDoItem toDoItem = toDoItems[index];
    return Container(
      child: Card(
        child: InkWell(
          onTap: () => toDoCubit.changeCompletionOfToDoItem(toDoItem),
          child: Row(
            children: <Widget>[
              radioButton(toDoItem),
              cardText(toDoItem),
              spacer(),
              editButton(toDoItem),
              deleteButton(toDoItem),
            ],
          ),
        ),
      ),
    );
  }

  Widget radioButton(ToDoItem toDoItem) {
    return Radio<bool>(
      value: toDoItem.isComplete,
      groupValue: true,
      onChanged: (_) => toDoCubit.changeCompletionOfToDoItem(toDoItem),
      toggleable: true,
    );
  }

  Widget cardText(ToDoItem toDoItem) {
    return Text(
      toDoItem.text,
      style: TextStyle(
        decoration: isCompletedTab ? TextDecoration.lineThrough : TextDecoration.none,
      ),
    );
  }

  Widget spacer() {
    return const Expanded(
      child: SizedBox(),
    );
  }

  Widget editButton(ToDoItem toDoItem) {
    return IconButton(
      onPressed: () => alertDialog(toDoItem),
      icon: const Icon(
        Icons.edit,
      ),
    );
  }

  Widget deleteButton(ToDoItem toDoItem) {
    return IconButton(
      onPressed: () => toDoCubit.removeToDoItem(toDoItem),
      icon: const Icon(
        Icons.delete,
      ),
    );
  }

  void alertDialog(ToDoItem toDoItem) {
    final EditToDoItemDialog dialog = EditToDoItemDialog(
      toDoItem: toDoItem,
      context: context,
    );
    dialog.showEditDialog();
  }
}
