import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_list_bloc/data/datasources/to_do_provider.dart';
import 'package:todo_list_bloc/data/models/to_do_item_model.dart';
import 'package:todo_list_bloc/domain/entities/to_do_item.dart';
import 'package:todo_list_bloc/domain/repositories/to_do_repository.dart';

class ToDoRepositoryImpl implements ToDoRepository {
  final ToDoProvider toDoProvider;

  ToDoRepositoryImpl({
    ToDoProvider? toDoProvider,
  }) : toDoProvider = toDoProvider ?? ToDoProvider();

  @override
  Future<List<ToDoItem>> getToDoItems() async {
    final String toDoItems = await toDoProvider.getToDoItems();
    final List<Object?> decodedItems = json.decode(toDoItems) as List<Object?>;

    return decodedItems
        .map<ToDoItem>(
          (Object? item) => ToDoItemModel.fromJson(item as Map<String, Object?>),
        )
        .toList();
  }

  @override
  Future<void> setToDoItems(List<ToDoItem> toDoItems) async {
    final List<Map<String, Object>> mappedToDoItems = toDoItems.map<Map<String, Object>>(ToDoItemModel.toMap).toList();
    final String encodedItems = json.encode(mappedToDoItems);
    await toDoProvider.setToDoItems(encodedItems);
  }

  @override
  Future<Locale> getTranslations() async {
    final String? languageCode = await toDoProvider.getTranslations();
    return languageCode != null ? Locale(languageCode) : const Locale('en');
  }

  @override
  Future<void> setTranslations(Locale locale) async {
    await toDoProvider.setTranslations(locale.languageCode);
  }
}
