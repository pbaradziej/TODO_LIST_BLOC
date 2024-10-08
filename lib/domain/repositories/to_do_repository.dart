import 'package:flutter/material.dart';
import 'package:todo_list_bloc/domain/entities/to_do_item.dart';

abstract class ToDoRepository {
  Future<List<ToDoItem>> getToDoItems();

  Future<void> setToDoItems(List<ToDoItem> toDoItems);

  Future<Locale> getTranslations();

  Future<void> setTranslations(Locale locale);
}
