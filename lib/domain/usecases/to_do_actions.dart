import 'dart:ui';

import 'package:todo_list_bloc/data/repositories/to_do_repository_impl.dart';
import 'package:todo_list_bloc/domain/entities/to_do_item.dart';
import 'package:todo_list_bloc/domain/repositories/to_do_repository.dart';

class ToDoActions {
  final ToDoRepository repository;

  ToDoActions({ToDoRepository? repository}) : repository = repository ?? ToDoRepositoryImpl();

  Future<List<ToDoItem>> getToDoItems() async {
    return repository.getToDoItems();
  }

  Future<void> setToDoItems(List<ToDoItem> toDoItems) async {
    return repository.setToDoItems(toDoItems);
  }

  Future<Locale> getTranslations() async {
    return repository.getTranslations();
  }

  Future<void> setTranslations(Locale locale) async {
    return repository.setTranslations(locale);
  }
}
