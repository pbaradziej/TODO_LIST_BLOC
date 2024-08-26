import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_bloc/domain/entities/to_do_item.dart';
import 'package:todo_list_bloc/l10n/l10n.dart';
import 'package:todo_list_bloc/presentation/cubit/to_do/to_do_cubit.dart';

class EditToDoItemDialog {
  final ToDoItem toDoItem;
  final BuildContext context;
  late TextEditingController editorToDoController;

  EditToDoItemDialog({
    required this.toDoItem,
    required this.context,
  }) : editorToDoController = TextEditingController(text: toDoItem.text);

  void showEditDialog() {
    showDialog<void>(
      context: context,
      builder: (final BuildContext context) {
        return AlertDialog(
          title: Text(context.translations.tab_edit_title),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                editorTextField(context),
              ],
            ),
          ),
          actions: <Widget>[
            dialogActions(context),
          ],
        );
      },
    );
  }

  Widget editorTextField(BuildContext context) {
    return TextField(
      controller: editorToDoController,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: context.translations.tab_edit_placeholder,
      ),
      onSubmitted: (_) {
        editToDoItem();
      },
    );
  }

  Widget dialogActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(context.translations.tab_edit_cancel),
        ),
        ElevatedButton(
          onPressed: () {
            editToDoItem();
            Navigator.of(context).pop();
          },
          child: Text(context.translations.tab_edit_save),
        ),
      ],
    );
  }

  void editToDoItem() {
    final ToDoCubit toDoCubit = context.read();
    final String toDoItemGuid = toDoItem.guid;
    final String text = editorToDoController.text;
    toDoCubit.editToDoItem(toDoItemGuid, text);
  }
}
