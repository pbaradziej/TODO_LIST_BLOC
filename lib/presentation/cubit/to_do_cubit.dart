import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_bloc/data/registers/to_do_register.dart';
import 'package:todo_list_bloc/domain/entities/to_do_item.dart';
import 'package:todo_list_bloc/domain/usecases/to_do_actions.dart';

part 'to_do_state.dart';

class ToDoCubit extends Cubit<ToDoState> {
  final ToDoActions toDoActions;
  final ToDoRegister _toDoRegister;

  ToDoCubit({
    ToDoActions? toDoActions,
  })  : toDoActions = toDoActions ?? ToDoActions(),
        _toDoRegister = ToDoRegister(),
        super(const ToDoState(status: ToDoStatus.initial));

  Future<void> initializeToDoItems() async {
    final List<ToDoItem> toDoItems = await toDoActions.getToDoItems();
    _toDoRegister.initializeToDoItems(toDoItems);
    _emitToDoState();
  }

  Future<void> addToDoItem(ToDoItem item) async {
    _toDoRegister.addToDoItem(item);
    await _setToDoItems();
    _emitToDoState();
  }

  Future<void> editToDoItem(String guid, String updatedText) async {
    _toDoRegister.editToDoItem(guid, updatedText);
    await _setToDoItems();
    _emitToDoState();
  }

  Future<void> removeToDoItem(ToDoItem item) async {
    _toDoRegister.removeToDoItem(item);
    await _setToDoItems();
    _emitToDoState();
  }

  Future<void> changeCompletionOfToDoItem(ToDoItem toDoItem) async {
    _toDoRegister.changeCompletionOfToDoItem(toDoItem);
    await _setToDoItems();
    _emitToDoState();
  }

  Future<void> _setToDoItems() async {
    final List<ToDoItem> toDoItems = _toDoRegister.toDoItems;
    await toDoActions.setToDoItems(toDoItems);
  }

  void _emitToDoState() {
    final ToDoState state = ToDoState(
      status: ToDoStatus.loaded,
      toDoItems: _toDoRegister.toDoItems,
    );
    emit(state);
  }
}
