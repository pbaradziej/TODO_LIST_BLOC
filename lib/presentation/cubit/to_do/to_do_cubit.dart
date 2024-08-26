import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_bloc/domain/entities/to_do_item.dart';
import 'package:todo_list_bloc/domain/usecases/to_do_actions.dart';

part 'to_do_state.dart';

class ToDoCubit extends Cubit<ToDoState> {
  final ToDoActions toDoActions;

  ToDoCubit({
    ToDoActions? toDoActions,
  })  : toDoActions = toDoActions ?? ToDoActions(),
        super(const ToDoState(status: ToDoStatus.initial));

  Future<void> initializeToDoItems() async {
    final List<ToDoItem> toDoItems = await toDoActions.getToDoItems();
    await _emitToDoState(toDoItems);
  }

  Future<void> addToDoItem(ToDoItem item) async {
    state.toDoItems.add(item);
    await _emitToDoState();
  }

  Future<void> editToDoItem(String guid, String updatedText) async {
    final int toDoItemIndex = state.toDoItems.indexWhere((ToDoItem item) => item.guid == guid);
    final ToDoItem toDoItem = state.toDoItems.elementAt(toDoItemIndex);
    state.toDoItems[toDoItemIndex] = toDoItem.copyWith(text: updatedText);
    await _emitToDoState();
  }

  Future<void> removeToDoItem(ToDoItem item) async {
    state.toDoItems.remove(item);
    await _emitToDoState();
  }

  Future<void> changeCompletionOfToDoItem(ToDoItem toDoItem) async {
    final int toDoItemIndex = state.toDoItems.indexOf(toDoItem);
    state.toDoItems[toDoItemIndex] = toDoItem.copyWith(isComplete: !toDoItem.isComplete);
    await _emitToDoState();
  }

  Future<void> _emitToDoState([List<ToDoItem>? toDoItems]) async {
    await toDoActions.setToDoItems(state.toDoItems);
    final ToDoState toDoState = ToDoState(
      status: ToDoStatus.loaded,
      toDoItems: toDoItems ?? state.toDoItems,
    );
    emit(toDoState);
  }
}
